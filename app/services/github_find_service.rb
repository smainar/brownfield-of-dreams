class GithubFindService
  def initialize(user, handle)
    @user = user
    @handle = handle
  end

  def find_email_by_handle
    get_json("/users/#{handle}")[:email]
    binding.pry
  end

  private
    def conn
      Faraday.new(url: "https://api.github.com") do |faraday|
        faraday.headers["Authorization"] = 'token ' + user.github_token
        faraday.adapter Faraday.default_adapter
      end
    end

    def get_json(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end

    attr_reader :handle,
                :user
end
