require 'rails_helper'

describe "A Registered Github user" do
  it "can add other registered github users as friends" do
    # VCR.use_cassette('github_user_friends', record: :new_episodes) do
      WebMock.allow_net_connect!
      VCR.turn_off!

      user1 = create(:github_user_friends)

      user2 = create(
        :github_user,
        github_handle: 'milevy1',
        github_url: 'https://github.com/milevy1'
      )
      user3 = create(
        :github_user,
        github_handle: 'Smainar',
        github_url: 'https://github.com/smainar'
      )

      allow_any_instance_of(ApplicationController).to
      receive(:current_user).and_return(user1)

      visit dashboard_path

      within(first('.github_followers')) do
        expect(page).to have_button("Add Friend")
      end

      click_on "Add Friend"

      expect(page).to have_content("#{user2.handle} has been added as friend.")

      within(first('.github_followers')) do
        expect(page).to_not have_button("Add Friend")
      end

      expect(page).to have_content("My Friends")

      within(first('.friend_list')) do
        expect(page).to have_link('milevy1')
      end
    # end
  end
end
