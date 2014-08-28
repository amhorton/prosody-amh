class VotesController < ApplicationController

  def create
    @vote = current_user.votes.new(vote_params)

    @vote.save

    redirect_to :back
  end

  def destroy

  end

  private

  def vote_params
    params.require(:vote).permit(:val, :votable_id, :votable_type)
  end


end