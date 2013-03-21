class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include UsersHelper
  include PostsHelper
  include CategoriesHelper

  def search
    @posts = Post.search(params[:search])
    @users = User.search(params[:search])
    @categories = Category.search(params[:search])
    @search_by = params[:search_by]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end

  end
end
