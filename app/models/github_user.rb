class GithubUser
  attr_reader :handle, 
              :url

  def initialize(github_profile)
    @handle = github_profile[:login]
    @url = github_profile[:html_url]
  end
end
