# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end


  def auth
    current_user.update_attribute(:github_token, auth_hash[:credentials][:token])

    redirect_to dashboard_path
  end

  def create
    if auth_hash
      auth
    else
      user = User.find_by(email: params[:session][:email])
      if user&.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to dashboard_path
      else
        flash[:error] = 'Looks like your email or password is invalid'
        render :new
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end


end
