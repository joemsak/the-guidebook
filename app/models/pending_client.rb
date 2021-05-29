class PendingClient < ApplicationRecord
  belongs_to :client_invitation, required: false
  belongs_to :coach_profile

  has_one :client_profile

  enum status: %i[
    pending
    invited
    accepted_invite
    rejected_invite
    converted
  ]
end
