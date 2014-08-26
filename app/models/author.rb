class Author < ActiveRecord::Base
  has_many(:articles)

  validates :last_name, presence: true

  def self.in_db?(fname, lname)
    Author.where(first_name: fname, last_name: lname).exists?
  end

  def name
    self.first_name + " " + self.last_name
  end
end
