class GithubUser
  attr_reader :handle,
              :url,
              :github_id

  def initialize(github_profile)
    @handle = github_profile[:login]
    @url = github_profile[:html_url]
    @github_id = github_profile[:id]
  end

  def can_be_friended?(current_user)
    has_brownfield_account? && !friends_already?(current_user)
  end

  def has_brownfield_account?
    follower = User.find_by(github_handle: self.handle)
    if follower
      true
    else
      false
    end
  end

  def friends_already?(current_user)
    follower = User.find_by(github_handle: self.handle)
    friendship = Friendship.find_by(user_id: current_user.id, friend_id: follower.id) || Friendship.find_by(friend_id: current_user.id, user_id: follower.id)
    if friendship
      true
    else
      false
    end
  end
end
