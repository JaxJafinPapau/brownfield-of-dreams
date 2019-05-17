# frozen_string_literal: true

class GithubService

  def initialize(github_token = nil)
    @github_token = github_token
  end

  def repository_info
    get_json('/user/repos')
  end

  def follower_info
    get_json('user/followers')
  end

  def following_info
    get_json('user/following')
  end

  def github_info(github_handle)
    get_json('users/:github_handle')
  end

  private

  def get_json(_url)
    response = conn.get(_url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.adapter Faraday.default_adapter
      if @github_token
        f.authorization :Bearer, @github_token
      end 
    end
  end
end
