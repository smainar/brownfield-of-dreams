class GithubService
  def create_repo
    get_json("/user/repos")
  end

  def create_github_followers
    get_json("/user/followers")
  end

  def create_github_following
    get_json("/user/following")
  end

  private
    def conn
      Faraday.new(url: "https://api.github.com") do |faraday|
        faraday.headers["Authorization"] = 'token ' + ENV['GITHUB_API_KEY']
        faraday.params['per_page'] = 5
        faraday.adapter Faraday.default_adapter
      end
    end

    def get_json(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end
end
