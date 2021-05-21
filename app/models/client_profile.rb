class ClientProfile < ApplicationRecord
  belongs_to :user

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
