class Vote < ActiveRecord::Base
  belongs_to(:votable, polymorphic: true)
  belongs_to(:user)

  validates :votable_id, uniqueness: {scope: :votable_type}
end
