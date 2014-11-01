# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class PostSub < ActiveRecord::Base
  validates :post, :sub, presence: true
  # validates :post_id, uniqueness: { scope: :sub_id }
  belongs_to :post
  belongs_to :sub
end
