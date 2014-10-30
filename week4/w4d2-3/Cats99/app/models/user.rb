# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string(255)
#  password_digest :string(255)
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, uniqueness: true
  after_initialize :ensure_session_token
  
  has_many :cats
  has_many :cat_rental_requests
  
  attr_reader :password
  
  def self.find_by_credentials(user_name, password)
    user = find_by(:user_name => user_name)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
  
  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
