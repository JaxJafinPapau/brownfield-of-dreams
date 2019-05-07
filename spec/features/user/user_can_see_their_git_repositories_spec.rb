require 'rails_helper'

describe 'as a logged in user on my dashboard' do
  before :each do
    @user = create(:user)

  end
  it 'I can see my github repositories' do
# As a logged in user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    # When I visit /dashboard
    visit dashboard_path

    # Then I should see a section for "Github"
    expect(page).to have_content("Github")
    # And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
    expect(page).to have_css(".repository", count: 5)

    within first ".repository" do
      expect(page).to have_content("My repository")
    end
  end
end
