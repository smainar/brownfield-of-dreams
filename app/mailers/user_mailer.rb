class UserMailer < ApplicationMailer
  default from: "no_reply@BrownfieldOfDreams.com"

  def account_activation_email(user)
    @user = user
    mail(to: @user.email, subject: "Please Activate Your Account")
  end


end
