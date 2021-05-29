class ClientProfile < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :pending_client, required: false

  validates :user, presence: true, if: -> { pending_client.blank? }
  validates :pending_client, presence: true, if: -> { user.blank? }

  has_many :invitations,
    as: :recipient,
    class_name: "ClientInvitation",
    dependent: :destroy

  has_many :coaches,
    through: :invitations,
    source: :sender,
    source_type: "CoachProfile"

  has_many :coaching_sessions,
    dependent: :destroy

  delegate :name, :email, :slug, to: :user, prefix: false
end
