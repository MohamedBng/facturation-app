FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      password { Faker::Internet.password(min_length: 6) }
      role { ["admin", "user"].sample }
      lastname { Faker::Name.last_name }
      firstname { Faker::Name.first_name }
    end
  end
