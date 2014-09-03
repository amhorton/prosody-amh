class Api::UsersController < ApplicationController

  def home

    if !!current_user
      @user = current_user
      render :home
    else
      redirect_to articles_url
    end

  end

  def notifications
    current_user.new_notifications = 0
    current_user.save!
    render :notifications
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

end