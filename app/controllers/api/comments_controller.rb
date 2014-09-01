class Api::CommentsController < ApplicationController

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      @comment.annotation.user.new_notifications += 1
      render json: @comment
    else
      render json: @comment.errors.full_messages, status: 422
    end

  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:text, :annotation_id)
  end

end