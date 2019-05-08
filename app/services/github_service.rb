class GithubService
  def initialize(username, key)
    @username = username
    @key = key
  end

  def find_repositories
    repos = get_json("#{@username}/repos")
    repos.first(5)
  end

  private

    def get_json(url)
      response = conn.get(url)
      data = JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new("https://api.github.com/users/") do |f|
        f.headers["X-Api-Key"] = ENV["#{@key}"]
        f.adapter Faraday.default_adapter
      end
    end
end
