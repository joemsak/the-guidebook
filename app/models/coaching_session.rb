class CoachingSession < ApplicationRecord
  has_rich_text :notes

  default_scope { order(start_time: :desc) }

  scope :completed, -> { where("end_time <= ?", Time.current) }

  belongs_to :client_profile
  belongs_to :coach_profile

  belongs_to :client, class_name: "ClientProfile", foreign_key: :client_profile_id
  belongs_to :coach, class_name: "CoachProfile", foreign_key: :coach_profile_id

  delegate :name, :email, :slug, to: :client, prefix: true
  delegate :name, :email, :slug, to: :coach, prefix: true

  def duration
    return event_type["duration"] if event_type["duration"]
    ((end_time - start_time) / 60).to_i
  end

  def join_url
    location["external_join_url"]
  end
end
