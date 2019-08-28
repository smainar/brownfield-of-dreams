require "rails_helper"
RSpec.describe UserMailer, type: :mailer do
  describe "sends email at registration" do
    before :each do
      @user = create(:user)
      @email = UserMailer.account_activation_email(@user)
    end

    it "user receives email" do
      expect(@email.subject).to eq("Please Activate Your Account")
      expect(@email.to).to eq([@user.email])
      expect(@email.from).to eq(["no_reply@BrownfieldOfDreams.com"])
    end
  end
end
