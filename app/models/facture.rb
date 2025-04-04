class Facture < ApplicationRecord
  belongs_to :client
  belongs_to :provider
  belongs_to :user
  has_many :items, dependent: :destroy

  accepts_nested_attributes_for :items, reject_if: :all_blank_custom?, allow_destroy: true

  enum status: { en_attente: 0, approuvé: 1 }

  def total_ht
    items.sum(:total_ht)
  end

  def total_ttc
    (total_ht * (1 + tva.to_f/ 100)).to_i
  end

  def all_blank_custom?(attributes)
    attributes['detail'].blank? && attributes['quantite'].blank? && attributes['prix_unitaire_ht'].blank?
  end
end
