require 'rails_helper'

describe 'A User on dashboard page' do
  it 'can see github followers' do
    # VCR.use_cassette('user_github_followers', record: :new_episodes) do
      WebMock.allow_net_connect!
      VCR.turn_off!

      user = create(:user)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user)

      visit '/dashboard'

      within('#github_followers') do
        expect(page).to have_content('Followers')
        expect(page.all('.follower_list').count).to eq(5)
        within(first('.follower_list')) do
          expect(page).to have_link("kylecornelissen")
        end
      end
    # end
  end
end
