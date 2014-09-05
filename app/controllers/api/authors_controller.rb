class Api::AuthorsController < ApplicationController

  def index
    @authors = Author.all
    render :index
  end

  def show
    @author = Author.find(params[:id])

    @author.make_page

    render partial: "show", locals: {author: @author}
  end

end