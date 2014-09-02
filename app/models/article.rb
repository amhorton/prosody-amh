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

  def text_with_links
    text = self.text.dup

    reversed_annotations = self.annotations.sort_by{|annotation| annotation.start}.reverse

    reversed_annotations.each do |annotation|
      text.insert((annotation.end), "</a>")
      text.insert(annotation.start, "<a id=#{annotation.id} class=annotation-link>")

    end

    text
  end

end
