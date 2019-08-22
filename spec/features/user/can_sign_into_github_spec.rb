require 'rails_helper'

describe "User on dashboard" do
  it "can log in to github account" do
    VCR.use_cassette('user_github_login', record: :new_episodes) do

      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/dashboard"

      expect(page).to_not have_content("Github")

      click_button "Connect to Github"

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Github")

      expect(page).to have_css(".github-repos", count: 5)

      within(first(".github-repos")) do
        expect(page).to have_link("brownfield-of-dreams")
      end
    end
  end
end
