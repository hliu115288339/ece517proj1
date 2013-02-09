class VotesController < ApplicationController
  before_filter :signed_in_user

  def create
    @post = Post.find(params[:vote][:post_id])
    @post.vote!(current_user)

    redirect_to @post
  end

  def destroy
    @post = Vote.find(params[:id]).post
    @post.unvote!(current_user)

    redirect_to @post

  end
end
