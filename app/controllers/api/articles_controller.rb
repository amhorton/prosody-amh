class Api::ArticlesController < ApplicationController
  before_filter :signed_in_check, only: [:new]

  def index
    @articles = Article.all
    render json: @articles
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
      render json: @article
    else
      render json: @article.errors.full_messages, status: 422
    end
  end

  def show
    @article = Article.find(params[:id])
    render json: @article
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
