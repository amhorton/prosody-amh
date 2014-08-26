class ArticlesController < ApplicationController

  def new
    @article = Article.new
    render :new
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to article_url(@article)
    else
      flash.now[:errors] = @article.errors.full_messages
      render :new
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
    params.require(:article).permit(:title, :text, :author_id)
  end


end