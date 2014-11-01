module PostsHelper
  def checked_sub(sub)
    @post.sub_ids.include?(sub.id) ? "checked" : ""
  end
end
