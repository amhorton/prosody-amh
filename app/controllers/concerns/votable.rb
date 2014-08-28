module Votable
  extend ActiveSupport::Concern

  included do
    has_many(:votes, as: :votable)
  end

  def total_votes
    self.votes.inject(0) {|result, vote| result + vote.val}
  end
  
  def can_vote(user)
    !self.votes.find_by_user_id(user.id)
  end

end