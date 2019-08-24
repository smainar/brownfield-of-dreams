require "rails_helper"

describe "A Registered Github user" do
  it "can add other registered github users as friends" do
    # VCR.use_cassette('github_user_friends', record: :new_episodes) do
      WebMock.allow_net_connect!
      VCR.turn_off!

      user_1 = create(:github_user)

      user_2 = create(
        :github_user,
        github_handle: 'smainar',
        github_url: 'https://github.com/smainar'
      )
      user_3 = create(
        :github_user,
        github_handle: 'Loomus',
        github_url: 'https://github.com/loomus'
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit dashboard_path

      within(first('.github-followers')) do
        expect(page).to have_link("Add Friend")
        click_on "Add Friend"
      end

      expect(page).to have_content("#{user_2.handle} has been added as friend.")

      within(first('.github-followers')) do
        expect(page).to_not have_button("Add Friend")
      end

      expect(page).to have_content("My Friends")

      within(first('.friend-list')) do
        expect(page).to have_link('smainar')
      end
    # end
  end
end
