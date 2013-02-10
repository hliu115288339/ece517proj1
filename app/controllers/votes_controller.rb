class VotesController < ApplicationController
  before_filter :signed_in_user

  def create
    @post = Post.find(params[:vote][:post_id])
    @post.vote!(current_user)

    respond_with @post
  end

  def destroy
    @post = Vote.find(params[:id]).post
    @post.unvote!(current_user)

    respond_with @post
  end
end
