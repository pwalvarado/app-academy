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

FactoryGirl.define do
  factory :goal do
    title do
      Faker::Company.bs
    end
    description do
      Faker::Company.catch_phrase
    end
  end
end
