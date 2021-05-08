FactoryBot.define do
  factory :client_invitation do
    name { "Joe Sak" }
    sequence(:email) { |n| "recipient-#{n}@example.com" }
    association(:sender, factory: :coach_profile)
  end
end
