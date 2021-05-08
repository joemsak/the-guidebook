# Preview all emails at http://localhost:3000/rails/mailers/client_invitation
class ClientInvitationPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/client_invitation/invitation
  def invitation
    ClientInvitationMailer.invitation
  end

end
