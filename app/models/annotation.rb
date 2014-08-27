class Annotation < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "400x400>" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  
  belongs_to(:user)
  belongs_to(:article)
  
  validates :text, :user, :article, :start, :end, presence: true
  
  def summary
    "#{self.created_at}: #{self.user.username} annotated #{self.article} with \"#{self.text}\""
  end
end
