require 'rails_helper'

describe 'As a User on my dashboard page' do
  it 'can see github members Im following' do
    VCR.use_cassette('user_github_following', record: :new_episodes) do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_content('Following')
      expect(page).to have_css('.github-following', count: 5)

      within(first('.github-following')) do
        expect(page).to have_link("joequincy")
      end
    end
  end
end
