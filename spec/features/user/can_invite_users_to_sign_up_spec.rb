require 'rails_helper'

describe 'As a registered github user' do
  before(:each) do
    user = create(:github_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it 'I can invite another github user with an email' do
    VCR.use_cassette('invite_github_user_visible_email', record: :new_episodes) do


      visit '/dashboard'
      click_link 'Send an Invite'

      expect(current_path).to eq('/invite')

      fill_in :github_handle, with: 'chakeresa'

      expect do
        click_button 'Send an Invite'
        sleep 1
      end.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('Successfully sent invite!')
    end
  end

  it 'I cannot invite a github user with a private email' do
    VCR.use_cassette('invite_user_private_email', record: :new_episodes) do
      visit '/dashboard'
      click_link 'Send an Invite'

      fill_in :github_handle, with: 'smainar'

      expect do
        click_button 'Send an Invite'
        sleep 1
      end.to change { ActionMailer::Base.deliveries.count }.by(0)

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end
