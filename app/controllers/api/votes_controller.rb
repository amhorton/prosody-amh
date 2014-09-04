class Api::VotesController < ApplicationController

  def create
    votable_type = vote_params[:votable_type]
    votable_id = vote_params[:votable_id]

    current_user.votes.where("votable_type = '#{votable_type}'").find_by_votable_id(votable_id).try(:delete)

    @vote = current_user.votes.new(vote_params)

    @vote.save!

    render json: @vote
  end

  def destroy

  end

  private

  def vote_params
    params.require(:vote).permit(:val, :votable_id, :votable_type)
  end


end