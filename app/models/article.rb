class Article < ActiveRecord::Base
  belongs_to(:user)
  belongs_to(:author)

  validates :title, presence: true
  validates :title, uniqueness: true

end
