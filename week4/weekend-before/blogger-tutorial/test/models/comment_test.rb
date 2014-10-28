# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  author_name :string(255)
#  body        :text
#  article_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
