require 'rails_helper'

describe 'as a logged in User with github connected' do
  before :each do
    @user = create(:user, github_token: ENV["GITHUB_API_KEY"], github_id: 40487417, email_confirmed: 'active')
  end
  it 'I can click Invite a Friend link' do
    VCR.use_cassette("services/find_github_information") do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path

      click_link "Invite a Friend!"

      expect(current_path).to eq('/invite')

      fill_in 'invitation[github_handle]', with: 'Stoovles'

      click_on 'Send Invite'

      expect(page).to have_content("Github user does not exist or has a private email.")

    end
  end
end
