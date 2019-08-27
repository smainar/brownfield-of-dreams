class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def activation_email(user)
    @user = user
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Please Activate Your Account')
  end
end
