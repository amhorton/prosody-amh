class Api::SearchesController < ApplicationController

  def search
    @results = PgSearch.multisearch(params[:term])
    render :results
  end




end