class Api::VotesController < ApplicationController

  def create
    current_user.votes.where(votable_type = vote_params(:votable_type))

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