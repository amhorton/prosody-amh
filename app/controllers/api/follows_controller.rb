class Api::FollowsController < ApplicationController

  def create
    @follow = current_user.out_follows.new({followed_id: params[:followed_id]})

    if @follow.save
      @follow.followed.new_notifications += 1
      @follow.followed.save
    end

    render json: @follow
  end

  def destroy
    target = current_user.out_follows.find_by_followed_id(params[:followed_id])

    target.delete

    render json: true
  end

end