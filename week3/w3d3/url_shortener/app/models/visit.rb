# == Schema Information
#
# Table name: visits
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  shortened_url_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Visit < ActiveRecord::Base
  validates :user_id, :presence => true
  validates :shortened_url_id, :presence => true
  
  belongs_to(
    :visitor,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )
  
  belongs_to(
    :visited_url,
    :class_name => "ShortenedUrl",
    :foreign_key => :shortened_url_id,
    :primary_key => :id
  )
  def self.record_visit!(user, shortened_url)
    Visit.create!(user_id: user.id, shortened_url_id: shortened_url.id)
  end
end
