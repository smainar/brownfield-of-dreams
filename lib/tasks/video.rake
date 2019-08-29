# frozen_string_literal: true

namespace :video do
  desc 'Update all Video records in the database where position column is nil'
  task update_nil_position: :environment do
    puts 'You are running rake task to update Video records with nil position'

    videos = Video.where(position: nil)
    videos.each do |video|
      video.update(:position, 0)
    end
  end
end
