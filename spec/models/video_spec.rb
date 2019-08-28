require 'rails_helper'

RSpec.describe Video, type: :model do
  describe "class methods" do
    it "::bookmarked_videos" do
      user = create(:user)

      tutorial_1 = create(:tutorial)

      video_1 = create(:video, title: "Title 1", tutorial: tutorial_1, position: 0)
      video_2 = create(:video, title: "Title 2", tutorial: tutorial_1, position: 2)
      video_3 = create(:video, title: "Title 3", tutorial: tutorial_1, position: 1)

      user_video_1 = create(:user_video, user: user, video: video_1)
      user_video_2 = create(:user_video, user: user, video: video_2)
      user_video_3 = create(:user_video, user: user, video: video_3)

      expect(Video.bookmarked_videos(user.id)).to eq([video_1, video_3, video_2])
    end
  end
end
