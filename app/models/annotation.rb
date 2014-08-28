class Annotation < ActiveRecord::Base
  include Votable

  has_attached_file :image, :styles => { :medium => "400x400>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  # validate :valid_start, :valid_end


  belongs_to(:user, inverse_of: :annotations)
  belongs_to(:article, inverse_of: :annotations)

  has_many(:comments)

  validates :text, :user_id, :article_id, :start, :end, presence: true

  def summary
    "#{self.created_at}: #{self.user.username} annotated #{self.article.title} with \"#{self.text}\""
  end

  def valid_start
    errors.add(:start, "Can't start annotation there.") if self.start < 0
  end

  def valid_end
    if self.end > self.article.text.length
      errors.add(:end, "Can't end annotation there")
    end
  end

  def sorted_comments
    self.comments.sort_by{|comment| comment.created_at}.reverse
  end
end
