# spec/factories/devis.rb
FactoryBot.define do
  factory :devi do
    association :client
    association :provider
    association :user
    number { Faker::Number.number(digits: 10) }
    description { Faker::Lorem.sentence }
    date_of_creation { Date.today }
    date_of_validity { Date.today + 30.days }
    start_date_of_service { Date.today + 7.days }
    intervention_location { Faker::Address.full_address }
    estimated_duration { [1, 2, 3, 4, 8, 12, 24].sample }
    duration_unit { [0, 1, 2, 3].sample }
    tva { [0, 5, 10, 20].sample }

    status { [0, 1].sample }
    vat_application_type { [0, 1, 2, 3, 4, 5, 6].sample }
    paid { [true, false].sample }
    payment_method_mask { [1, 2, 4, 8, 16].sample(rand(1..5)).reduce(0, :|) }
  end
end
