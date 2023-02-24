require 'redis'

class User
  include ActiveModel::Validations

  attr_accessor :id, :username, :password_digest

  REDIS = Redis.new(url: ENV['REDIS_URL'])

  validates :username, presence: true
  validate :username_uniqueness
  validates :password, presence: true, length: { minimum: 8 }

  def initialize(id: nil, username:, password: nil, password_digest: nil)
    @id = id
    @username = username
    @password = password
    @password_digest = password_digest
  end

  def self.find_by_username(username)
    user_id = REDIS.smembers("users:#{username}").first
    user_data = REDIS.hgetall("users:#{user_id}")
    return nil if user_data.empty?

    User.new(id: user_data['id'], username: user_data['username'], password_digest: user_data['password_digest'])
  end

  def self.find(id)
    user_data = REDIS.hgetall("users:#{id}")
    return nil if user_data.empty?

    User.new(id: user_data['id'], username: user_data['username'], password_digest: user_data['password_digest'])
  end

  def self.authenticate(username, password)
    user = User.find_by_username(username)
    return unless user

    return unless BCrypt::Password.new(user.password_digest) == password

    user
  end

  def save
    return unless self.valid?

    self.id ||= REDIS.incr('user_id')
    self.password_digest ||= BCrypt::Password.create(self.password)
    REDIS.hset("users:#{id}", "id", id, "username", username, "password_digest", password_digest)
    REDIS.sadd("users:#{username}", "#{id}")
    self
  end

  private

  def username_uniqueness
    if User.find_by_username(self.username).present?
      errors.add(:username, "has already been taken")
    end
  end

  attr_accessor :password
end
