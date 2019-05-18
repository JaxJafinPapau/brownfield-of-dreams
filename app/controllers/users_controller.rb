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
    user = User.create(user_params)
    if user.save
      UserMailer.registration_confirmation(user).deliver_now
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Email already exists'
      redirect_to '/register'
    end
  end

  def update
    response = request.env['omniauth.auth']
    current_user.update(github_token: response['credentials']['token'], github_id: response['extra']['raw_info']['id'])
    redirect_to dashboard_path
  end

  def confirm_email
    user = User.find_by(confirm_token: params[:token])
    if user
      user.email_activation
      flash[:success] = "Thank you! Your account is now activated."
      redirect_to dashboard_path
    else
      flash[:error] = "Something went wrong, please try again."
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
