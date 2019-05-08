require 'rails_helper'

describe 'as a logged in user on my dashboard' do
  before :each do
    @user = create(:user, github_username: "jaxjafinpapau")
    @keys = @user.api_keys.create(github: ENV["GITHUB_API_KEY"])
  end
  it 'I can see my github repositories' do
    VCR.use_cassette("services/view_gets_repositories") do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      # When I visit /dashboard
      visit dashboard_path

      # Then I should see a section for "Github"
      expect(page).to have_content("Github")
      # And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
      expect(page).to have_css(".repository", count: 5)

      within first ".repository" do
        expect(page).to have_content("2win_playlist")
      end
    end
  end
end
