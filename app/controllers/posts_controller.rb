class PostsController < ApplicationController
  include SessionsHelper

  before_filter :correct_user,   only: [:edit, :destroy]

  #show all posts
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = root_post_of(Post.find(params[:id]))

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  def new_comment
    @post = Post.find(params[:id])
    @comment = @post.comments.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  def create
    @post = current_user.posts.build(params[:post])
    @root_post = root_post_of(@post)

    respond_to do |format|
      if @post.save
        touch_updated_at(@post)
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    @root_post = root_post_of(@post)

    respond_to do |format|
      if @post.update_attributes(params[:post])
        touch_updated_at(@post)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  def vote
    @post = Post.find(params[:id])
    @vote = @post.votes.build(user_id: current_user.id)

    respond_to do |format|
      if @vote.save
        touch_updated_at(@post)
        format.html { redirect_to @post, notice: 'Successfully like the post.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @post, notice: 'Fail to like the post'}
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end

  end

  def unvote
    @post = Post.find(params[:id])
    @vote = @post.votes.find_by_user_id(current_user.id)

    respond_to do |format|
      if @vote.destroy
        touch_updated_at(@post)
        format.html { redirect_to @post, notice: 'Successfully unlike the post.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @post, notice: 'Fail to unlike the post'}
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def show_liked
    @post = Post.find(params[:id])
  end

  private
    def correct_user
      @post = current_user.posts.find_by_id(params[:id])
      if @post.nil?
        redirect_to root_url, notice: "this post does not belong to you" unless current_user.admin
      end
    end

    def touch_updated_at(post)
        current_post = post
        current_post.touch(:updated_at)
        while !current_post.parent_post_id.nil? do
          current_post = Post.find_by_id(current_post.parent_post_id)
          current_post.touch(:updated_at)
        end
    end

    def root_post_of(post)
      root_post = post
      while !root_post.parent_post_id.nil? do
        root_post = Post.find_by_id(root_post.parent_post_id)
      end
      root_post
    end
end
