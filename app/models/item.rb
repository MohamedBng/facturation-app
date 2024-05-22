class Item < ApplicationRecord
  belongs_to :devi, optional: true
  belongs_to :facture, optional: true
  monetize :prix_unitaire_ht, as: "price", allow_nil: true

  before_save :calculate_total_ht

  has_rich_text :detail

  private

  def calculate_total_ht
    self.total_ht = prix_unitaire_ht.to_i * quantite.to_i
  end
end
