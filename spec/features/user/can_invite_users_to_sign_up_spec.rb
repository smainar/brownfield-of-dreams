require 'rails_helper'


describe 'As a registered github user' do
  before(:each) do
    user = create(:github_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it 'I can invite another github user with an email' do
    # VCR.use_cassette('invite_github_user', record: :new_episodes) do
    WebMock.allow_net_connect!
    VCR.turn_off!

      visit '/dashboard'
      click_link 'Send an Invite'

      expect(current_path).to eq('/invite')

      fill_in :github_handle, with: 'smanair'

      expect do
        click_button 'Send an Invite'
        sleep 1
      end.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('Successfully sent invite!')
    # end
  end

  xit 'I cannot invite a github user with a private email' do
    VCR.use_cassette('invite_private_github_user', record: :new_episodes) do
      visit '/dashboard'
      click_link 'Send an Invite'

      fill_in :github_handle, with: 'kylecornelissen'
      expect do
        click_button 'Send Invite'
        sleep 1
      end.to change { ActionMailer::Base.deliveries.count }.by(0)

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end



# As a registered user
# When I visit /dashboard
# And I click "Send an Invite"
# Then I should be on /invite
#
# And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
# And I click on "Send Invite"
# Then I should be on /dashboard
# And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
# Or I should see a message that says "The Github user you selected doesn't have an email address associated with their account."
