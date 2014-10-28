# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string(255)
#  name        :string(255)      not null
#  sex         :string(255)      not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base
  validates :birth_date, timeliness: { on_or_before: Date.current }
  validates :color, inclusion: { in: ["red", "blue", "yellow", "purple"],
    message: "NOT A COLOR OF A CAT" }
  validates :sex, inclusion: { in: ["M", "F"],
    message: "THAT'S NOT A SEX" }
  validates :birth_date, :name, :sex, presence: true
  
  def age
    (Date.current - @birth_date)/365
  end
end
