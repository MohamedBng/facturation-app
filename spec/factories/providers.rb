# spec/factories/providers.rb
FactoryBot.define do
  factory :provider do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    postal_code { Faker::Address.zip_code }
    num_siret { Faker::Number.number(digits: 14) }
    starting_quotation_number { 1 }
    starting_invoice_number { 1 }
    primary_color { "#009688" }
    secondary_color { "#00796B" }
    background_color { "#FFFFFF" }
    text_color { "#333333" }
    user

    after(:build) do |provider|
      image_path = Rails.root.join('spec', 'fixtures', 'logo.png')
      provider.logo = File.open(image_path, 'rb') if File.exist?(image_path)
    end
  end
end
