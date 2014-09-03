class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      sign_in_user(@user)
      redirect_to "/#"
    else
      flash.now[:errors] = ["cannot find user with those credentials"]
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to "/#"
  end

end