class GithubUser
  attr_reader :handle,
              :url

  def initialize(github_profile)
    @handle = github_profile[:login]
    @url = github_profile[:html_url]
  end

  def can_be_friended?(current_user)
    binding.pry
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
      binding.pry
      true
    else
      false
    end
  end
end
