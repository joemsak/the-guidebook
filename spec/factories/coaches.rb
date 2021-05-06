FactoryBot.define do
  factory :coach do
    name { "Jayson Gaddis" }
    sequence(:email) { |n| "coach-#{n}@example.com" }

    password { "secret123" }
    password_confirmation { "secret123" }
  end
end
