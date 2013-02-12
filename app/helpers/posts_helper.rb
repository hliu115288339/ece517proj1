module PostsHelper
  def root_post?(post)
    post.parent_post_id.nil?
  end



end
