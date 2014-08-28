class Comment < ActiveRecord::Base
  include Votable
  
  validates :user_id, :annotation_id, presence: true

  belongs_to(:user)
  belongs_to(:annotation)

  def summary
    "#{self.user.username} commented on your annotation on #{self.annotation.article.title}"
  end
end
