class ClientProfile < ApplicationRecord
  belongs_to :user

  has_many :invitations,
    as: :recipient,
    class_name: "ClientInvitation",
    dependent: :destroy

  has_many :coaching_sessions,
    dependent: :destroy

  delegate :name, :email, to: :user, prefix: false
end
