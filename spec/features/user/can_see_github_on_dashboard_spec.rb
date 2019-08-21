require 'rails_helper'

describe "User on dashboard" do
  it "can see 5 github repositories" do
    # VCR.use_cassette('github_auth', record: :new_episodes) do
WebMock.allow_net_connect!
VCR.turn_off!
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/dashboard"

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Github")

      within(first(".github-repos")) do
        expect(page).to have_link("1903_final")
      end

      expect(page).to have_css(".github-repos", count: 5)
save_and_open_page
      expect((".github-repos")[0]).to eq("1903_final")
      expect((".github-repos")[0]).to have_link("1903_final")
      click_link("1903_final")
      expect(current_path).to eq("https://github.com/MillsProvosty/1903_final")
    #end
  end
end


# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
