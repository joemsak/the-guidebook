class CoachProfile < ApplicationRecord
  belongs_to :user

  def self.friendly
    User.friendly
  end

  has_many :client_invitations, as: :sender, dependent: :destroy

  has_many :completed_client_invitations,
    -> { completed },
    as: :sender,
    class_name: "ClientInvitation"

  has_many :clients,
    through: :completed_client_invitations,
    source: :recipient,
    source_type: "ClientProfile"

  has_many :pending_clients, dependent: :destroy
  has_many :imported_events, dependent: :destroy
  has_many :coaching_sessions, dependent: :destroy

  delegate :name, :email, :slug,
    to: :user,
    prefix: false,
    allow_nil: false
end
