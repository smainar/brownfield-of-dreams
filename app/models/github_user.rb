class GithubUser
  attr_reader :handle,
              :url

  def initialize(github_profile)
    @handle = github_profile[:login]
    @url = github_profile[:html_url]
  end

  def friend?(current_user)
    if !friend_finder(current_user) && self.handle
    end
  end

  def has_github_account?(current_user)
    follower = User.find_by(github_handle: self.handle)
    if follower && Friendship.find_by(user_id: current_user.id, friend_id: follower.id) || Friendship.find_by(friend_id: current_user.id, user_id: follower.id)

    end
  end
end
