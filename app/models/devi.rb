class Devi < ApplicationRecord
  belongs_to :client
  belongs_to :provider
  belongs_to :user
  has_many :items, -> { order(created_at: :asc) }, dependent: :destroy

  has_rich_text :description
  has_rich_text :payment_terms
  monetize :deposit, as: "total_deposit", allow_nil: true
  monetize :global_discount, as: "global_discount_price", allow_nil: true

  accepts_nested_attributes_for :items, reject_if: :all_blank_custom?, allow_destroy: true

  enum status: { en_attente: 0, approuvé: 1 }
  enum vat_application_type: {
    taux_uniforme: 0,
    taux_variable: 1,
    auto_liquidation_en_sous_traitance: 2,
    auto_liquidation_commerce_intra_communautaire_vente_de_biens: 3,
    auto_liquidation_commerce_intra_communautaire_prestation_de_service: 4,
    non_assujeti_franchise_en_base: 5,
    exonerations_ventes_hors_union_européenne: 6,
  }
  enum duration_unit: { heures: 0, jours: 1, mois: 2, années: 3}
  enum simple_payment_method: {
    cash: 1,
    credit_card: 2,
    bank_transfer: 4,
    check: 8,
    paypal: 16
  }
  enum global_discount_type: { price: 0, percent: 1 }

  validate :tva_consistency
  validates :duration_unit, presence: { message: "doit être indiquée si une durée estimée est fournie" }, if: -> { estimated_duration.present? }
  before_create :set_default_date_of_creation

  def total_ht
    items.sum(:total_ht)
  end

  def discount
    discount_cents_format = global_discount.to_i * 100
    global_discount_type == 'price' ? discount_cents_format : total_ht * global_discount.to_i / 100
  end

  def global_discount_percent_value
    global_discount_type == 'percent' ? total_ht * global_discount.to_i / 100 : nil
  end

  def total_ttc
    if vat_application_type == 'taux_variable'
      total = items.inject(0) { |sum, item| sum + (item.total_ht * (1 + item.tva.to_f / 100)).to_i }
      total - discount if discount
    else
      total = (total_ht * (1 + tva.to_f / 100)).to_i
      total - discount if discount
    end
  end

  def total_net
    total_ttc - deposit.to_i
  end


  def all_blank_custom?(attributes)
    attributes['detail'].blank? && attributes['quantite'].blank? && attributes['prix_unitaire_ht'].blank?
  end

  def tva_consistency
    if tva == 0 && vat_application_type == 'taux_uniforme'
      errors.add(:tva, "ne peut pas être à 0% si le type de TVA est uniforme")
    end
  end

  def payment_methods=(methods)
    methods = methods.reject(&:blank?)
    values = methods.map { |method| Devi.simple_payment_methods[method.to_sym] }.reduce(0, :|)
    write_attribute(:payment_method_mask, values)
  end

  def payment_methods
    Devi.simple_payment_methods.keys.select do |method|
      (read_attribute(:payment_method_mask) || 0) & Devi.simple_payment_methods[method] != 0
    end
  end


  private

  def set_default_date_of_creation
    self.date_of_creation ||= self.created_at
  end
end
