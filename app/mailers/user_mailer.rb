class UserMailer < ApplicationMailer
  default from: "no_reply@BrownfieldOfDreams.com"

  def account_activation_email(user)
    @user = user
    binding.pry
    mail(to: user.email, subject: "Please Activate Your Account")
    binding.pry
  end
end
