# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

FactoryGirl.define do
  factory :user do
    username do
      Faker::Internet.user_name
    end
    
    password do
      Faker::Internet.password
    end
  end
end
