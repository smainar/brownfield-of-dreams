require "rails_helper"
RSpec.describe UserMailer, type: :mailer do
  describe 'sends email at registration' do
    before :each do
      @user = create(:user)
      @mail = UserMailer.activation_email(@user)
    end


  end
end
