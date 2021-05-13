FactoryBot.define do
  factory :coaching_session do
    client_profile
    coach_profile
    starts_at { 1.week.from_now }
    duration { 1 }
    duration_unit { :hours }
  end
end
