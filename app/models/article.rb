class Article < ActiveRecord::Base
  include Votable

  belongs_to(:user)
  belongs_to(:author)

  has_many(:annotations)

  validates :title, presence: true
  validates :title, uniqueness: true

  def summary
    "#{self.created_at}: #{self.user.username} uploaded #{self.title}"
  end

  def url
    "/articles/#{self.id}"
  end

end
