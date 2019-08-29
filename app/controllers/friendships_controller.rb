# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    new_friend = User.find_by(github_handle: params[:new_friend_handle])
    friendship = current_user.friendships.new(friend_id: new_friend.id)
    if friendship.save
      flash[:success] = "#{params[:new_friend_handle]} has been added as a friend."
      redirect_to dashboard_path
    else
      flash[:error] = 'Unable to add friend.'
      redirect_to dashboard_path
    end
  end
end
