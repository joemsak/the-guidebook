class Coach < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: [:slugged, :history]

  validates :email, email: { mode: :strict }
  validates :name, :email, presence: true

  has_secure_password

  def should_generate_new_friendly_id?
    name_changed?
  end
end
