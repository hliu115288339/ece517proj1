require 'test_helper'

class PostTest < ActiveSupport::TestCase
  #Test title too short (min=5)
  def test_should_not_create_post_with_short_title
    post = build_post("merr", "validContent", "1","1", "1")
    assert !post.save, "Saved post with title too short"
  end

  def test_should_not_create_post_with_empty_title
    post = build_post("", "validContent", "1","1", "1")
    assert !post.save, "Saved post with title empty"
  end
  ###Content
  #Test content too short (min=10)
  def test_should_not_create_post_with_short_content
    post = build_post("validTitle", "short", "1","1", "1")
    assert !post.save, "Saved post with title too short"
  end
  #Test content empty
  def test_should_not_create_post_with_empty_content
    post = build_post("validTitle", "", "1","1", "1")
    assert !post.save, "Saved post with title empty"
  end
  ##user_id
  #Test user_id empty
  def test_should_not_create_post_with_empty_userID
    post = build_post("validTitle", "validContent", "","1", "1")
    assert !post.save, "Saved post with title empty"
  end
  ##category_id
  #Test category empty
  def test_should_not_create_post_with_empty_catID
    post = build_post("validTitle", "validContent", "1","", "1")
    assert !post.save, "Saved post with title empty"
  end
  private
  def build_post (title, content, userID, catID, parentPostID)
    post = Post.new
    post.title = title
    post.content= content
    post.user_id= userID
    post.category_id= catID
    post.parent_post_id= parentPostID
    post
  end

end
