# frozen_string_literal: true

require 'rails_helper'

describe 'User' do
  it 'user can sign in' do
    VCR.use_cassette('user_can_sign_in', record: :new_episodes) do
      user = create(:github_user)

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content(user.email)
      expect(page).to have_content(user.first_name)
      expect(page).to have_content(user.last_name)
    end
  end

  it 'can log out', :js do
    VCR.use_cassette('user_can_log_out', record: :new_episodes) do
      user = create(:user)

      visit login_path

      fill_in'session[email]', with: user.email
      fill_in'session[password]', with: user.password

      click_on 'Log In'

      click_on 'Profile'

      expect(current_path).to eq(dashboard_path)

      click_on 'Log Out'

      expect(current_path).to eq(root_path)
      expect(page).to_not have_content(user.first_name)
      expect(page).to have_content('SIGN IN')
    end
  end

  it 'is shown an error when incorrect info is entered' do
    VCR.use_cassette('user_is_shown_error', record: :new_episodes) do
      user = create(:user)
      fake_email = 'email@email.com'
      fake_password = '123'

      visit login_path

      fill_in'session[email]', with: fake_email
      fill_in'session[password]', with: fake_password

      click_on 'Log In'

      expect(page).to have_content('Looks like your email or password is invalid')
    end
  end
end
