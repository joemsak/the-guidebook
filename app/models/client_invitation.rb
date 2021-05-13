class ClientInvitation < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  include FailsWithException
  fails_with_exception :status, resolved_when: :sent

  belongs_to :sender, polymorphic: true
  belongs_to :recipient, polymorphic: true, required: false

  enum status: %i[
    created
    sent
    failed
    accepted
    rejected
    completed
  ]

  validates :name, :email, presence: true
  validates :email, email: { mode: :strict, allow_blank: true }
  validate :email, :does_not_match_sender

  after_commit :send_email, if: :send_email?

  delegate :email, to: :sender, prefix: true

  def send_email
    ClientInvitationMailer.invitation(id).deliver_later
  end

  private
  def send_email?
    !accepted? && !rejected? && saved_change_to_email?
  end

  def does_not_match_sender
    if sender.email == email
      errors.add(:email, :cannot_match_sender)
    end
  end
end
