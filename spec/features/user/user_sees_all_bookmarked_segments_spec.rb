# frozen_string_literal: true

require 'rails_helper'

describe 'As a logged in user' do
  describe 'User Dashboard: Bookmarks' do
    it 'I should see a list of all bookmarked segments under the Bookmarked Segments section' do
      VCR.use_cassette('user_bookmarked_videos', record: :new_episodes) do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to
        receive(:current_user).and_return(user)

        tutorial_1 = create(:tutorial)

        video_1 = create(:video, title: 'Title 1', tutorial: tutorial_1, position: 0)
        video_2 = create(:video, title: 'Title 2', tutorial: tutorial_1, position: 2)
        video_3 = create(:video, title: 'Title 3', tutorial: tutorial_1, position: 1)

        user_video_1 = create(:user_video, user: user, video: video_1)
        user_video_2 = create(:user_video, user: user, video: video_2)
        user_video_3 = create(:user_video, user: user, video: video_3)

        tutorial_2 = create(:tutorial)

        video_4 = create(:video, title: 'Title 4', tutorial: tutorial_2, position: 0)
        video_5 = create(:video, title: 'Title 5', tutorial: tutorial_2, position: 1)

        user_video_4 = create(:user_video, user: user, video: video_4)
        user_video_5 = create(:user_video, user: user, video: video_5)

        visit '/dashboard'

        expect(page).to have_content('Bookmarked Segments')

        within(first('.bookmarked-tutorials')) do
          expect(page).to have_content(tutorial_1.title)
          expect(page.all('li')[0]).to have_link(video_1.title)
          expect(page.all('li')[1]).to have_link(video_3.title)
          expect(page.all('li')[2]).to have_link(video_2.title)
        end

        within(page.all('.bookmarked-tutorials').last) do
          expect(page).to have_content(tutorial_2.title)
          expect(page.all('li')[3]).to have_link(video_4.title)
          expect(page.all('li')[4]).to have_link(video_5.title)
        end
      end
    end
  end
end
