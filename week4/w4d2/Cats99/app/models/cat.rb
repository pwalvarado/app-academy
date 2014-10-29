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
  COLORS = %w{red blue yellow purple}
  SEXES = %w{M F}
  
  validates :birth_date, timeliness: { on_or_before: Date.current }
  validates :color, inclusion: { in: COLORS,
    message: "NOT A COLOR OF A CAT" }
  validates :sex, inclusion: { in: SEXES,
    message: "THAT'S NOT A SEX" }
  validates :birth_date, :name, :sex, presence: true
  
  has_many(
    :cat_rental_requests,
    dependent: :destroy
  )
  
  
  def age
    (Date.current - @birth_date)/365
  end
end
