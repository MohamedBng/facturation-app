class Item < ApplicationRecord
  belongs_to :devi
  monetize :prix_unitaire_ht, as: "price"

  before_save :calculate_total_ht

  private

  def calculate_total_ht
    self.total_ht = prix_unitaire_ht.to_i * quantite.to_i
  end
end
