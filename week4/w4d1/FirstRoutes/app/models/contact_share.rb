# == Schema Information
#
# Table name: contact_shares
#
#  id         :integer          not null, primary key
#  contact_id :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class ContactShare < ActiveRecord::Base
  validates :user_id, :contact_id, presence: true
  validates :contact_id, uniqueness: {scope: :user_id} 
  
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :contact,
    class_name: "Contact",
    foreign_key: :contact_id,
    primary_key: :id
  )
  
end
