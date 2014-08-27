class Annotation < ActiveRecord::Base
  belongs_to(:user)
  belongs_to(:article)
  
  validates :text, :user, :article, :start, :end, presence: true
  
  def summary
    "#{self.created_at}: #{self.user.username} annotated #{self.article} with \"#{self.text}\""
  end
end
