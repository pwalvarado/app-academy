class Note < ActiveRecord::Base
  validates :user_id, :track_id, :body, presence: true
  validates :body, uniqueness: { scope: [:user_id, :track_id] }
  belongs_to :user
  belongs_to :track
  delegate :email, to: :user, prefix: true
end
