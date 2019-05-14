class Follower
  attr_reader :handle, :url, :github_id
  def initialize(data)
    @handle = data[:login]
    @url  = data[:html_url]
    @github_id = data[:id]
  end


  def follower_has_account?(user)
    User.exists?(github_id: self.github_id) && !user.friends.exists?(github_id: self.github_id)
  end
end
