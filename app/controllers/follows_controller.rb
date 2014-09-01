class FollowsController < ApplicationController

  def create
    @follow = current_user.out_follows.new(follow_params)

    if @follow.save
      @follow.followed.new_notifications += 1
      redirect_to user_url(@follow.followed)
    end
  end

  def destroy
    followed = nil
    current_user.out_follows.each do |out_follow|
      if out_follow.followed_id = follow_params[:followed_id]
        followed = User.find(follow_params[:followed_id])
        out_follow.delete
      end
    end

    redirect_to user_url(followed)
  end

  private

  def follow_params
    params.require(:follow).permit(:followed_id)
  end

end