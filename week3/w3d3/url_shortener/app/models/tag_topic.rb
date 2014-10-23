# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  topic      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class TagTopic < ActiveRecord::Base
  has_many(
    :taggings,
    :class_name => "Tagging",
    :foreign_key => :tag_topic_id,
    :primary_key => :id
  )
  
  has_many(
    :shortened_urls,
    :through => :taggings,
    :source => :shortened_url
  )
end
