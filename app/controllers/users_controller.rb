# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    render locals: {
      facade: UserDashboardFacade.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      if @user.status == "inactive"
        flash[:success] = "This account has not yet been activated. Please check your email."
        render :activate
      elsif user.status == "active"
        redirect_to dashboard_path
      end
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    response = request.env['omniauth.auth']
    current_user.update(github_token: response['credentials']['token'], github_id: response['extra']['raw_info']['id'])
    redirect_to dashboard_path
  end

  def confirm_email
    current_user.update(status: "active")
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
