FactoryBot.define do
  factory :client do
    nom_complet { Faker::Name.name }
    adresse { Faker::Address.street_address }
    ville { Faker::Address.city }
    code_postal { Faker::Address.zip_code }
    num_siret { Faker::Number.number(digits: 14) }
    phone_number { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    user
  end
end

