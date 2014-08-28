class Vote < ActiveRecord::Base
  belongs_to(:votable, polymorphic: true)
  belongs_to(:user)

  validates :votable_id, uniqueness: {scope: :votable_type}
  validate :vote_too_large

  def vote_too_large
    errors.add(:val, "Vote game too strong") if self.val.abs > 1
  end

end
