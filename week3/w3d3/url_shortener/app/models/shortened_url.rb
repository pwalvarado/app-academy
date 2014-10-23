# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :text
#  short_url    :string(255)
#  submitter_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  
  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id
  )
  
  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :shortened_url_id,
    :primary_key => :id
  )
  
  has_many(
    :visitors,
    -> { distinct },
    :through => :visits,
    :source => :visitor
  )
  
  has_many(
    :taggings,
    :class_name => "Tagging",
    :foreign_key => :shortened_url_id,
    :primary_key => :id
  )
  
  has_many(
    :tag_topics
    :through => :taggings,
    :source => :tag_topic
  )
  
  def self.random_code
    loop do
      code = SecureRandom::urlsafe_base64[0..15]
      return code unless ShortenedUrl.exists?(short_url: code)
    end
  end
  
  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      long_url: long_url,
      short_url: ShortenedUrl.random_code,
      submitter_id: user.id
    )
  end
  
  def num_clicks
    visits.count
  end
  
  def num_uniques
    visitors.count
  end
  
  def num_recent_uniques(time)
    Visit.where(:shortened_url_id => 1)
      .where("created_at > ?", time)
      .select(:user_id).distinct.count
  end
  
end
