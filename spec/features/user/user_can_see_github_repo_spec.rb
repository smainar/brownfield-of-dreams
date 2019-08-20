require "rails_helper"
# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
describe "As a logged in User", type: :feature do
  before(:each) do
    @user = create(:user)

    @repo_1 = create(:repository, name "Repo 1")
    @repo_2 = create(:repository, name "Repo 2")
    @repo_3 = create(:repository, name "Repo 3")
    @repo_4 = create(:repository, name "Repo 4")
    @repo_5 = create(:repository, name "Repo 5")

    # create_list(:repository, 5)

    # @github_repo_1 = Repository.create!(name: "Repo 1")
    # @github_repo_2 = Repository.create!(name: "Repo 2")
    # @github_repo_3 = Repository.create!(name: "Repo 3")
    # @github_repo_4 = Repository.create!(name: "Repo 4")
    # @github_repo_5 = Repository.create!(name: "Repo 5")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "I should see a section for 'Github'" do
    visit "/dashboard"

    expect(page).to have_content("Github")
    expect(page).to have_css(.)

    within "#github-repo" do
      expect(page).to have_css(".github")
      expect(page).to have_content(@repo_1.name)
      expect(page).to have_link(@repo_1.name)
    end

    # within "#github" do
    #   expect(page.all('li')[0]).to have_content("Name: #{@github_repo_1.name}")
    #   expect(page.all('li')[1]).to have_content("Name: #{@github_repo_2.name}")
    #   expect(page.all('li')[2]).to have_content("Name: #{@github_repo_3.name}")
    #   expect(page.all('li')[3]).to have_content("Name: #{@github_repo_3.name}")
    #   expect(page.all('li')[4]).to have_content("Name: #{@github_repo_3.name}")
    #
    #   expect(page).to have_link(@github_repo_1.name)
    #   expect(page).to have_link(@github_repo_2.name)
    #   expect(page).to have_link(@github_repo_3.name)
    #   expect(page).to have_link(@github_repo_4.name)
    #   expect(page).to have_link(@github_repo_5.name)
    # end
  end
end
