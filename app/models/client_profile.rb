class ClientProfile < ApplicationRecord
  belongs_to :user

  has_many :invitations, as: :recipient, class_name: "ClientInvitation"
end
