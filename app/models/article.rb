class Article < ActiveRecord::Base
  include Votable

  include PgSearch

  multisearchable against: [:title, :text], using: {tsearch: {prefix: true}}

  belongs_to(:user)
  belongs_to(:author)

  has_many(:annotations)

  validates :title, presence: true
  validates :title, uniqueness: true

  def summary
    "#{self.created_at}: #{self.user.username} uploaded #{self.title}"
  end

  def search_summary
    "<strong>Article</strong>: #{self.title} by #{self.author.name} (#{self.year})"
  end

  def url
    "#articles/#{self.id}"
  end

  def text_with_links
    text = self.text.dup

    reversed_annotations = self.annotations.sort_by{|annotation| annotation.start}.reverse

    reversed_annotations.each do |annotation|
      #handle annotations that go right up to the end of text
      
      if annotation.end + 1 >= text.length - 1 
        text += "</a>"
      else
        text.insert((annotation.end + 1), "</a>")
      end
      
      text.insert(annotation.start, "<a id=#{annotation.id} class=annotation-link>")
    end

    text
  end

end
