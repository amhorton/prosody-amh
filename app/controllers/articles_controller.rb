class ArticlesController < ApplicationController
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
      redirect_to "/#articles/#{@article.id}"
    else
      flash.now[:errors] = @article.errors.full_messages
      render :new
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :year)
  end

  def author_params
    params.require(:author).permit(:first_name, :last_name)
  end


end