class ClientProfile < ApplicationRecord
  belongs_to :user

  has_many :client_invitations, as: :recipient
end
