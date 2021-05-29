FactoryBot.define do
  factory :imported_event do
    client_profile { nil }
    pending_client { nil }
    coach_profile { nil }
    client_invitation { nil }
  end
end
