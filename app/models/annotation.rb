class Annotation < ActiveRecord::Base
  include Votable

  include PgSearch
  multisearchable against: :text, using: {tsearch: {prefix: true}}

  has_attached_file :image, :styles => { :medium => "400x400>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :text, :user_id, :article_id, :start, :end, presence: true
  validate :no_overlap


  belongs_to(:user, inverse_of: :annotations)
  belongs_to(:article, inverse_of: :annotations)

  has_many(:comments)

  #custom validation

  def no_overlap
    overlap = false

    self.article.annotations.each do |annotation|
      unless self.start >= annotation.end || self.end <= annotation.start
        overlap = true
      end
    end

    self.errors.add(:start, "No overlappin'") if overlap
  end

  #display methods

  def summary
    "#{self.user.username} annotated #{self.article.title} with \"#{self.text}\""
  end

  def search_summary
    str = "<strong>Annotation</strong> on #{self.article.title}: #{self.text[0..25]}"
    str += "..." if self.text.length > 25
    str
  end

  def url
    "#articles/#{self.article_id}"
  end

  def snippet
    Article.find(self.article_id).text[(self.start)..(self.end)]
  end

  def title
    text_start = self.text[0..20]
    text_start += "..." if self.text.length > 20
    text_start
  end

  def sorted_comments
    self.comments.sort_by{|comment| comment.created_at}.reverse
  end
end
