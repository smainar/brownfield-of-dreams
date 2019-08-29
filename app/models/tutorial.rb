# frozen_string_literal: true

class Tutorial < ApplicationRecord
  has_many :videos, ->  { order(position: :ASC) }, dependent: :destroy

  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def self.bookmarked_tutorials(user_id)
    includes(videos: :user_videos)
      .where('user_videos.user_id = ?', user_id)
      .order('videos.tutorial_id, videos.position')
  end
end
