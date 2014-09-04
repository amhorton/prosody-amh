class User < ActiveRecord::Base

  include PgSearch

  multisearchable against: :username, using: {tsearch: {prefix: true}}

  #avatar support

  has_attached_file :avatar, :styles => { :medium => "250x250>", :thumb => "100x100>" }, :default_url => "green_:style.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  #basic associations

  has_many(:articles)
  has_many(:annotations)
  has_many(:comments)
  has_many(:votes)

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

  #validations

  validates :username, :password_digest, presence: true

  before_validation :ensure_session_token

  #authentication

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    return false unless user

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

  def search_summary
    "<strong>User</strong>: #{self.username}"
  end

  def url
    "#users/#{self.id}"
  end

  def events
    events = (self.articles_from_followed_users + self.in_follows + self.comments_on_annotations + self.annotations_on_articles).sort_by { |event| event.created_at }
    events.sort_by{ |event| event.created_at}.reverse
  end

  def articles_from_followed_users
    articles = []
    self.followed_users.each do |user|
      articles += user.articles
    end
    articles
  end

  def annotations_on_articles
    annotations = []
    self.articles.each do |article|
      annotations += article.annotations
    end
    annotations
  end

  def comments_on_annotations
    comments = []
    self.annotations.each do |annotation|
      comments += annotation.comments
    end
    comments
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

  def total_votes
    votes = 0
    self.comments.each { |comment| votes += comment.total_votes}
    self.articles.each { |article| votes += article.total_votes}
    self.annotations.each { |annotation| votes += annotation.total_votes}

    votes
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_token
  end


end
