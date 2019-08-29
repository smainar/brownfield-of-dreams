# frozen_string_literal: true

require 'rails_helper'

describe 'As a visitor', type: :feature do
  describe 'Tutorials - Classroom Content' do
    it "tutorials marked as 'classroom content' are invisible to visitors" do
      VCR.use_cassette('hide_classroom_content_from_visitors', record: :new_episodes) do
        user = create(:user)

        tutorial_1 = create(:tutorial, classroom: true)
        tutorial_2 = create(:tutorial, classroom: true)
        tutorial_3 = create(:tutorial, classroom: false)

        video_1 = create(:video, tutorial: tutorial_1)
        video_2 = create(:video, tutorial: tutorial_2)
        video_3 = create(:video, tutorial: tutorial_3)

        visit root_path

        expect(page).to_not have_content(tutorial_1.title)
        expect(page).to_not have_content(tutorial_2.title)
        expect(page).to have_content(tutorial_3.title)
      end
    end
  end
end
