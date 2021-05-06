class Coach < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: [:slugged, :history]

  validates :name, :email, presence: true

  validates :email,
    email: { mode: :strict, allow_blank: true },
    uniqueness: true

  has_secure_password
  has_secure_token :auth_token, length: 32

  def should_generate_new_friendly_id?
    name_changed?
  end
end
