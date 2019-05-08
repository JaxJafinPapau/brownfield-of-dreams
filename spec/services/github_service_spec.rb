require 'rails_helper'

describe GithubService do
  context "instance methods" do
    it "gets repositories" do
      VCR.use_cassette("services/find_repositories") do
        user = create(:user, github_username: "jaxjafinpapau")
        key = user.api_keys.create(github: ENV["GITHUB_API_KEY"])

        service = GithubService.new(user.github_username, key)
        repositories = service.find_repositories
        repository = repositories.first

        expect(repositories.count).to eq(5)
        expect(repository[:name]).to eq("2win_playlist")
      end
    end
  end
end
