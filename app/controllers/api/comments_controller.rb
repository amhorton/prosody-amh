class Api::CommentsController < ApplicationController

  def index
    @comments = Annotation.find(params[:annotation_id]).comments
    render :index
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.annotation_id = params[:annotation_id]

    if @comment.save
      @comment.annotation.user.new_notifications += 1
      @comment.annotation.user.save
      render json: @comment
    else
      render json: @comment.errors.full_messages, status: 422
    end

  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

end