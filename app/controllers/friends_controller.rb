class FriendsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @friend = current_user.friends.new(github_id: params[:github_id])
    @friend.save
    redirect_to dashboard_path
  end

end
