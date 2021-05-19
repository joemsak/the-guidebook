FactoryBot.define do
  factory :authentication do
    user
    sequence(:provider) { |n| "provider-#{n}" }
    sequence(:uid) { "uid-#{n}" }
    info { {} }
    credentials { {} }
    extra { {} }
  end
end
