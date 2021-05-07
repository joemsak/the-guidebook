FactoryBot.define do
  factory :user do
    name { "Jayson Gaddis" }
    sequence(:email) { |n| "user-#{n}@example.com" }

    password { "secret123" }
    password_confirmation { "secret123" }
  end
end
