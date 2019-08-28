require 'rails_helper'

describe "As a visitor", type: :feature do
  describe "Tutorial Show Page" do
    it "displays a list of all videos associated with that tutorial" do
      tutorial = create(:tutorial)

      video_1 = create(:video, tutorial: tutorial, title: "Title 1")
      video_2 = create(:video, tutorial: tutorial, title: "Title 2")
      video_3 = create(:video, tutorial: tutorial, title: "Title 3")

      visit tutorial_path(tutorial)

      within "#tutorial-video-list" do
        expect(page).to have_css(".show-link", count: 3)
        expect(first(".show-link")).to have_content(video_1.title)
        expect(page.all(".show-link")[1]).to have_content(video_2.title)
        expect(page.all(".show-link")[2]).to have_content(video_3.title)
      end
    end

    it "displays a message if a tutorial doesn't have any videos" do
      tutorial = create(:tutorial)

      visit tutorial_path(tutorial)

      expect(page).to have_content("Currently, there are no videos for this tutorial.")
    end
  end
end
