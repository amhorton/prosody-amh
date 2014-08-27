class Comment < ActiveRecord::Base
  validates :user, :annotation, presence: true
  
  belongs_to(:user)
  belongs_to(:annotation)
  
  def summary
    "#{self.user.username} commented on your annotation on #{self.annotation.article.title}"
  end
end
