class User < ActiveRecord::Base
  attr_reader :password
  validates :session_token, presence: true, uniqueness: true
  validates :password_digest,
            :presence => { :message => "Password can't be blank" }
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :cats,
  foreign_key: :user_id,
  primary_key: :id,
  class_name: "Cat"


  before_validation :ensure_session_token

  def self.generate_session_token!
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token!
    self.save!
    self.session_token
  end

  def password=(plain_text)
    if plain_text.present?
      @password = plain_text
      self.password_digest = BCrypt::Password.create(plain_text)
    end
  end

  def is_password?(plain_text)
    p plain_text
    p self.password_digest
    BCrypt::Password.new(self.password_digest).is_password?(plain_text)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)
    # return nil if user.nil?
    user.try(:is_password?, password) ? user : nil
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token!
  end

end
