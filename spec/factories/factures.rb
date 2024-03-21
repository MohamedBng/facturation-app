FactoryBot.define do
  factory :facture do
    client { nil }
    tva { "9.99" }
    status { 1 }
    liquidation_tva { false }
  end
end
