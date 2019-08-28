class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  def self.bookmarked_videos(user_id)
    self.select("videos.*")
      .joins(:user_videos)
      .where("user_videos.user_id = ?", user_id)
      .order(:tutorial_id, :position)
  end
end
