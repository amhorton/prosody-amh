class Api::AuthorsController < ApplicationController

  def index
    @authors = Author.all
    render :index
  end

  def show
    @author = Author.find(params[:id])
    render :show
  end

end