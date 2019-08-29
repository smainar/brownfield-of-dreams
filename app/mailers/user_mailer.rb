# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'no_reply@BrownfieldOfDreams.com'

  def account_activation_email(user)
    @user = user
    mail(to: user.email, subject: 'Please Activate Your Account')
  end

  def invite_user(invitee, inviter, invitee_email)
    @invitee = invitee
    @inviter = inviter
    mail(to: invitee_email, subject: "You've been invited to create an account!")
  end
end
