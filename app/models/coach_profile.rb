class CoachProfile < ApplicationRecord
  belongs_to :user

  has_many :client_invitations, as: :sender

  delegate :name, :email,
    to: :user,
    prefix: false,
    allow_nil: false
end
