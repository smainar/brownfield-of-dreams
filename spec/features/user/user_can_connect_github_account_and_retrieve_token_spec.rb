require "rails_helper"

# As a user
# When I visit /dashboard
# Then I should see a link that is styled like a button that says "Connect to Github"
# And when I click on "Connect to Github"
# Then I should go through the OAuth process
# And I should be redirected to /dashboard
# And I should see all of the content from the previous Github stories (repos, followers, and following)
describe "As a user" do
  describe "User Dashboard: Github OAuth" do
    it "link that is styled like a button that says 'Connect to Github'" do
      # VCR.use_cassette('github_auth', record: :new_episodes) do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        
        WebMock.allow_net_connect!
        VCR.turn_off!
        visit "/dashboard"

        expect(page).to_not have_content("Github Repos")
        expect(page).to_not have_content("Followers")
        expect(page).to_not have_content("Following")

        expect(page).to have_link("Connect to Github")
        click_on "Connect to Github"
        expect(current_path).to eq("/dashboard")

        expect(page).to have_content("Github Repos")
        expect(page).to have_content("Followers")
        expect(page).to have_content("Following")

        expect(page).to have_css(".github-repos", count: 5)
        expect(page).to have_css(".github-followers", count: 5)
        expect(page).to have_css(".github-following", count: 5)
      # end
    end
  end
end
