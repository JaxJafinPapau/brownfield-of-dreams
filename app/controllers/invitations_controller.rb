# frozen_string_literal: true

class InvitationsController < ApplicationController
  def new; end

  def create
    if github_data[:email]
      github_email = github_data[:email]
      UserMailer.github_invite(current_user, github_email).deliver_now
      flash[:notice] = 'Successfully sent invite!'
      redirect_to root_url
    else
      flash[:notice] = 'Github user does not exist or has a private email.'
      redirect_to '/invite'
    end
  end

  private

  def github_data
    @_github_data ||= service.github_info(params[:invitation][:github_handle])
  end

  def service
    @_service ||= GithubService.new
  end
end
