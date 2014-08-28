class Comment < ActiveRecord::Base
  validates :user_id, :annotation_id, presence: true

  belongs_to(:user)
  belongs_to(:annotation)
  
  has_many(:votes, as: :votable)

  def summary
    "#{self.user.username} commented on your annotation on #{self.annotation.article.title}"
  end
end
