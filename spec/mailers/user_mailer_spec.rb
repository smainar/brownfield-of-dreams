require "rails_helper"
RSpec.describe UserMailer, type: :mailer do
  describe "sends email at registration" do
    before :each do
      @user = create(:user)
      @email = UserMailer.activation_email(@user)
    end

    describe "user receives email" do
      expect(@email.subject).to eq("Please Activate Your Account")
      expect(@email.to).to eq([@user.email])
      expect(@email.from).to eq(['no_reply@brownfieldofdreams.com'])
      expect(@email.body.encoded) .to match("Click here to activate your account:")
    end
  end
end
