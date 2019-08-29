# frozen_string_literal: true

require 'rails_helper'

describe 'As a logged in user', type: :feature do
  describe 'Classroom Content' do
    it "tutorials marked as 'classroom content' are viewable only if the user is logged in" do
      VCR.use_cassette('logged_in_user_sees_classroom_content', record: :new_episodes) do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to
        receive(:current_user).and_return(user)

        tutorial_1 = create(:tutorial, classroom: true)
        tutorial_2 = create(:tutorial, classroom: true)
        tutorial_3 = create(:tutorial, classroom: false)

        video_1 = create(:video, tutorial: tutorial_1)
        video_2 = create(:video, tutorial: tutorial_2)
        video_3 = create(:video, tutorial: tutorial_3)

        visit root_path

        expect(page).to have_content(tutorial_1.title)
        expect(page).to have_content(tutorial_2.title)
        expect(page).to have_content(tutorial_3.title)
      end
    end
  end
end
