class CoachProfile < ApplicationRecord
  belongs_to :user

  delegate :name, :email,
    to: :user,
    prefix: false,
    allow_nil: false
end
