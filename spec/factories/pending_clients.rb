FactoryBot.define do
  factory :pending_client do
    email { "MyString" }
    name { "MyString" }
    status { 1 }
    client_invitation { nil }
    coach_profile { nil }
  end
end
