class Follow < ActiveRecord::Base
  belongs_to(
    :follower,
    class_name: "User",
  )

  belongs_to(
    :followed,
    class_name: "User",
  )

  validates :followed_id, uniqueness: {scope: :follower_id}

  def summary
    "#{self.follower.username} followed you."
  end

  def url
    "users/#{follower_id}"
  end
end
