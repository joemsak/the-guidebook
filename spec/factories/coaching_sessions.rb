FactoryBot.define do
  factory :coaching_session do
    client_profile
    coach_profile
    sequence(:external_id) { |n| "event-uuid-#{n}" }
    sequence(:external_url) { |n| "https://example-events.com/event/#{n}" }
    sequence(:name) { |n| "Event ##{n}" }
    external_status { "active" }
    start_time { 2.days.from_now }
    end_time { 2.days.from_now + 1.hour }
    external_created_at { 1.week.ago }
    external_updated_at { 1.week.ago }
    event_type { {} }
    location { {} }
    invitees_counter_total { 1 }
    invitees_counter_active { 1 }
    invitees_counter_limit { 1 }
  end
end
