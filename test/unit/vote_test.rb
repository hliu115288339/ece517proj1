require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  ###Test userID
  #Test empty name
  def test_should_not_create_vote_with_empty_user
    vote = build_vote("", "1")
    assert !vote.save, "Saved name with empty userID"
  end

  ###Test postID
  #Test empty name
  def test_should_not_create_vote_with_empty_post
    vote = build_vote("1", "")
    assert !vote.save, "Saved name with empty postID"
  end

  private
  def build_vote(userID, postID)
    vote = Vote.new
    vote.user_id = userID
    vote.post_id= postID
    vote
  end
end
