class ImportedEvent < ApplicationRecord
  belongs_to :coach_profile
  belongs_to :client_profile

  has_one :coaching_session

  enum status: %i[
    imported
    reviewed
    converted
  ]
end
