FactoryBot.define do
  factory :item do
    devis { nil }
    detail { "MyText" }
    quantite { 1 }
    prix_unitaire_ht { 1 }
    total_ht { 1 }
  end
end
