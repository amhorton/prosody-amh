class User < ActiveRecord::Base

  has_attached_file :avatar, :styles => { :medium => "250x250>", :thumb => "100x100>" }, :default_url => "green_:style.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many(:articles)
  has_many(:annotations)

  has_many(
    :out_follows,
    class_name: "Follow",
    foreign_key: :follower_id
  )

  has_many(
    :in_follows,
    class_name: "Follow",
    foreign_key: :followed_id
  )

  has_many(:followers, through: :in_follows, source: :follower)

  has_many(:followed_users, through: :out_follows, source: :followed)

  validates :username, :password_digest, presence: true

  before_validation :ensure_session_token

  #authentication

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    user.is_password?(password) ? user : nil
  end

  def self.generate_token
    SecureRandom.urlsafe_base64
  end

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token
    self.session_token = self.class.generate_token
    self.save!
    self.session_token
  end

  #custom methods

  def events
    (self.annotations + self.articles).sort_by { |event| event.created_at }
  end

  def recent_events
    self.events[0..5]
  end

  def followed_activity
    events = []

    self.followed_users.each do |followed_user|
      events += followed_user.events
    end

    events.sort_by { |event| event.created_at }
  end

  def can_follow?(user)
    !(user == self || self.followed_users.include?(user))
  end

  def can_unfollow?(user)
    self.followed_users.include?(user)
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_token
  end


end
