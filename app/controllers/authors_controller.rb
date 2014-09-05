class AuthorsController < ApplicationController

  def new
    @author = Author.new
    render :new
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      redirect_to author_url(@author)
    else
      flash.now[:errors] = @author.errors.full_messages
      render :new
    end
  end

  def show
    @author = Author.find(params[:id])
    
    render :show
  end

  private

  def author_params
    params.require(:author).permit(:first_name, :last_name)
  end


end