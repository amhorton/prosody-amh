require 'wikipedia'

class Author < ActiveRecord::Base
  include PgSearch

  multisearchable against: [:first_name, :last_name], using: {tsearch: {prefix: true}}

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_many(:articles)

  validates :last_name, presence: true
  validates :first_name, uniqueness: {scope: :last_name}

  def self.in_db?(fname, lname)
    Author.where(first_name: fname, last_name: lname).exists?
  end

  def self.find_or_create_by_name(fname, lname)
    if Author.in_db?(fname, lname)
      return Author.where(first_name: fname, last_name: lname).first
    else
      author = Author.new({first_name: fname, last_name: lname})
      if author.save
        return author
      else
        return false
      end
    end
  end

  #Logic for talking to APIs and getting info for show page.

  def find_and_set_image
    if image.url.index("missing")
      results = []
      search = Google::Search::Image.new do |search|
        search.query = self.name
        search.size = :small
      end
      search.find { |item| results << item }
      url = results.first.uri

      self.image = url if url
        
      self.save!
    end
  end


  def find_and_set_info
    unless self.info
      content = Wikipedia.find(self.name).sanitized_content
      if content
        first_para_end = content.index("</p>")
        first_para = content[3...first_para_end]
        self.info = first_para + "  <i>--Wikipedia</i>"
      else
        self.info = "We couldn't find info on this author."
      end
      
      self.save!
    end
  end

  def make_page
    self.find_and_set_info

    self.find_and_set_image
  end
  
  #display methods

  def name
    self.first_name + " " + self.last_name
  end

  def search_summary
    "<strong>Author</strong>: #{self.name}"
  end

  def url
    "/#authors/#{self.id}"
  end
end
