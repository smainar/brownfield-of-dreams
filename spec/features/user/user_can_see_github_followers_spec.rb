require "rails_helper"

# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see another section titled "Followers"
# And I should see list of all followers with their handles linking to their Github profile

describe "As a logged in User", type: :feature do
  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe "Github section" do
    # VCR.use_cassette('github_auth', record: :new_episodes) do
      WebMock.allow_net_connect!
      VCR.turn_off!
      it "I should see list of all followers with their handles linking to their Github profile" do
        visit "/dashboard"

        expect(page).to have_content("Github Followers")
        expect(page).to have_css(".github-followers")

        within ".github-followers" do
          expect(page).to have_content("Andrew Johnson")
          expect(page).to have_link("Loomus")
          click_on "Loomus"
        end
        expect(current_path).to eq("https://github.com/Loomus")
      end
    # end
  end
end
