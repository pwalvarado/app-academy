# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  url        :string(255)
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates :title, :author_id, :subs, presence: true

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs
  has_many(
    :top_level_comments,
    -> { where(parent_comment_id: "NULL") },
    class_name: "Comment"
  )

  has_many(
    :comments,
    -> { includes(:author) },
    class_name: "Comment"
  )

  def comments_by_parent_id
    parent_comment_hash = Hash.new { |h, k| h[k] = [] }
    comments.each do |comment|
      parent_comment_hash[comment.parent_comment_id] << comment
    end

    parent_comment_hash
  end
end
