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

  def new
    redirect_to user_url(current_user) if !!current_user
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in_user(@user)
      redirect_to home_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:username, :password, :avatar)
  end

end