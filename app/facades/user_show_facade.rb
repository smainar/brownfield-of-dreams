class UserShowFacade
  def initialize(current_user)
    @user = current_user
  end

  def github_service
    GithubService.new(user)
  end

  def user_repos
    connection = github_service.create_repo

    connection.map do |r|
      GithubRepo.new(r)
    end
  end

  def user_github_followers
    connection = github_service.create_github_followers

    connection.map do |follower|
      GithubUser.new(follower)
    end
  end

  def user_github_following
    connection = github_service.create_github_following

    connection.map do |following|
      GithubUser.new(following)
    end
  end

  def bookmarked_tutorials
    Tutorial.bookmarked_tutorials(user)
  end

  private
    attr_reader :user
end
