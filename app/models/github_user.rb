class GithubUser
  attr_reader :name,
              :url

  def initialize(user_info)
    @handle = user_info[:login]
    @url = user_info[:html_url]
  end
end
