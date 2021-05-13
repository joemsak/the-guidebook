class ClientProfile < ApplicationRecord
  belongs_to :user

  has_many :invitations, as: :recipient, class_name: "ClientInvitation"

  has_many :coaching_sessions

  delegate :name, :email, to: :user, prefix: false
end
