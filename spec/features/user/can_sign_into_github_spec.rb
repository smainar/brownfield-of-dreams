# frozen_string_literal: true

require 'rails_helper'

describe 'User on dashboard' do
  it 'can log in to github account' do
    VCR.use_cassette('user_github_login', record: :new_episodes) do
      test_omniauth

      user = create(:user)
      allow_any_instance_of(ApplicationController).to
      receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to_not have_content('Github Repos')

      click_link 'Connect to Github'

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content('Github Repos')
    end
  end
end
