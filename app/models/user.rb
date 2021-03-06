class User < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: [:slugged, :history]

  validates :name, :email, presence: true

  validates :email,
    email: { mode: :strict, allow_blank: true },
    uniqueness: true

  has_secure_password
  has_secure_token :auth_token, length: 32

  has_one :admin_profile, dependent: :destroy
  has_one :coach_profile, dependent: :destroy
  has_one :client_profile, dependent: :destroy

  has_many :authentications, dependent: :destroy

  default_scope -> { order(:created_at) }

  scope :admin, -> { joins(:admin_profile) }
  scope :coach, -> { joins(:coach_profile) }
  scope :client, -> { joins(:client_profile) }

  scope :clients_of, ->(coach) {
    joins(client_profile: :invitations)
      .where(client_invitations: { sender: coach })
  }

  def create_profile(type)
    send("create_#{type}_profile") unless has_profile?(type)
  end

  def has_profile?(type)
    begin
      send("#{type}_profile").present?
    rescue NoMethodError
      false
    end
  end

  def connected_service?(provider)
    authentications.exists?(provider: provider)
  end

  def should_generate_new_friendly_id?
    name_changed?
  end
end
