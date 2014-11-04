# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  description :text
#  user_id     :integer          not null
#  completed   :boolean          default(FALSE), not null
#  public      :boolean          default(FALSE), not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Goal < ActiveRecord::Base
  validates :title, :user_id, presence: true
  validates_inclusion_of :completed, :public, :in => [true, false]
  
  belongs_to :user
end
