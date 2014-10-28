# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  username   :string(255)
#

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  
  has_many(
    :contacts,
    dependent: :destroy,
    class_name: "Contact",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
  :contact_shares,
  dependent: :destroy,
  class_name: "ContactShare",
  foreign_key: :user_id,
  primary_key: :id
  )
  
  has_many(
    :shared_contacts,
    through: :contact_shares,
    source: :contact
  )
end
