# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password, length: { minimum: 4, allow_nil: true }

  after_initialize :ensure_session_token

  attr_reader :password

  def self.find_by_credentials(user_params)
    user = find_by(email: user_params[:email])
    return nil if user.nil?
    user.is_password?(user_params[:password]) ? user : nil
  end

  def self.new_session_token
    SecureRandom.urlsafe_base64
  end

  def password=(password)
    return unless password.present?

    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = self.class.new_session_token
    save!
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.new_session_token
  end
end
