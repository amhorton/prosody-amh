class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)

    @comment.save

    redirect_to article_url(@comment.annotation.article)
  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:text, :annotation_id)
  end
end