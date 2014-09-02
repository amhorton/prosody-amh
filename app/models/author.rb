class Author < ActiveRecord::Base
  include PgSearch

  multisearchable against: [:first_name, :last_name]

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

  def name
    self.first_name + " " + self.last_name
  end
end
