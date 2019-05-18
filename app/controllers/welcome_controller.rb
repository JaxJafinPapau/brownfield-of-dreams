# frozen_string_literal: true

class WelcomeController < ApplicationController
  # the style of conditional used here is much more readable than the style suggested by rubocop
  # rubocop:disable Style/ConditionalAssignment
  def index
    if params[:tag]
      @tutorials = Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    elsif current_user.nil?
      @tutorials = Tutorial.all.where(classroom: false).paginate(page: params[:page], per_page: 5)
    else
      @tutorials = Tutorial.all.paginate(page: params[:page], per_page: 5)
    end
  end
  # rubocop:enable Style/ConditionalAssignment
end
