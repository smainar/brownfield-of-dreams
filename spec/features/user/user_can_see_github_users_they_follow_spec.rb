# frozen_string_literal: true

require 'rails_helper'

describe 'As a logged in user' do
  describe 'Github section - Following' do
    it 'I should see a list of users I follow with their handles linking to their Github' do
      VCR.use_cassette('github_following', record: :new_episodes) do
        user = create(:github_user)
        allow_any_instance_of(ApplicationController).to
        receive(:current_user).and_return(user)

        visit '/dashboard'

        expect(page).to have_content('Following')
        expect(page).to have_css('.github-following', count: 5)

        within(first('.github-following')) do
          expect(page).to have_link('pschlatt')
        end
      end
    end
  end
end
