class CoachingSession < ApplicationRecord
  default_scope { order(starts_at: :desc) }

  belongs_to :client_profile
  belongs_to :coach_profile

  belongs_to :client, class_name: "ClientProfile", foreign_key: :client_profile_id
  belongs_to :coach, class_name: "CoachProfile", foreign_key: :coach_profile_id

  validates :starts_at, :duration, :duration_unit, presence: true

  enum duration_unit: %i[
    hours
    minutes
  ], _default: :hours

  delegate :name, :email, to: :client, prefix: true
  delegate :name, :email, to: :coach, prefix: true
end