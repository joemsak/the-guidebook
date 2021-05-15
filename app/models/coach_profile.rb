class CoachProfile < ApplicationRecord
  belongs_to :user

  has_many :client_invitations, as: :sender, dependent: :destroy

  has_many :completed_client_invitations,
    -> { completed },
    as: :sender,
    class_name: "ClientInvitation"

  has_many :clients,
    through: :completed_client_invitations,
    source: :recipient,
    source_type: "ClientProfile"

  has_many :coaching_sessions, dependent: :destroy

  delegate :name, :email,
    to: :user,
    prefix: false,
    allow_nil: false
end
