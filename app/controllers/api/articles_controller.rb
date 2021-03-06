class Api::ArticlesController < ApplicationController

  def index
    @articles = Article.all
    render :index
  end

  def create

    @article = current_user.articles.new(article_params)
    @author = Author.find_or_create_by_name(
      author_params[:first_name],
      author_params[:last_name]
    )

    if @author
      @article.author_id = @author.id
    end

    if @article.save
      @article.user.followers.each do|follower|
        follower.new_notifications += 1
        follower.save
      end

      render json: @article
    else
      render json: @article.errors.full_messages, status: 422
    end
  end

  def show
    @article = Article.find(params[:id])
    render :show
  end

  def destroy

  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :year)
  end

  def author_params
    params.require(:author).permit(:first_name, :last_name)
  end

end
