class VotesController < ApplicationController
  before_filter :signed_in_user

  def create
    @post = Post.find_by_id(:post_id)
    vote = @post.votes.build(user_id: current_user.id)

    respond_to do |format|
      if vote.save
        format.html { redirect_to @post, notice: 'successfully liked.' }
        format.json { render json: @post, status: :created, location: @post }
      else

      end
    end

  end

  def destroy
    @post = Post.find_by_id(:post_id)
    @post.unvote!(current_user)

    respond_to do |format|
      format.html { redirect_to @post, notice: 'successfully unliked.' }
      format.json { render json: @post, status: :created, location: @post }
    end
  end

  def show
    @votes = Vote.find(params[:id]).post

  end
end
