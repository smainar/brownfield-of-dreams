require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe "class methods" do
    it "::bookmarked_tutorials" do
      user = create(:user)

      tutorial_1 = create(:tutorial)

      video_1 = create(:video, title: "Video 1", tutorial: tutorial_1, position: 0)
      video_2 = create(:video, title: "Video 2", tutorial: tutorial_1, position: 2)
      video_3 = create(:video, title: "Video 3", tutorial: tutorial_1, position: 1)

      user_video_1 = create(:user_video, user: user, video: video_1)
      user_video_2 = create(:user_video, user: user, video: video_2)
      user_video_3 = create(:user_video, user: user, video: video_3)

      tutorial_2 = create(:tutorial)

      video_4 = create(:video, title: "Video 4", tutorial: tutorial_2, position: 1)
      video_5 = create(:video, title: "Video 5", tutorial: tutorial_2, position: 0)

      user_video_4 = create(:user_video, user: user, video: video_4)
      user_video_5 = create(:user_video, user: user, video: video_5)

      expect(Tutorial.bookmarked_tutorials(user.id)).to eq([tutorial_1, tutorial_2])
      expect(Tutorial.bookmarked_tutorials(user.id)[0].videos).to eq([video_1, video_3, video_2])
      expect(Tutorial.bookmarked_tutorials(user.id)[1].videos).to eq([video_5, video_4])
    end
  end
end
