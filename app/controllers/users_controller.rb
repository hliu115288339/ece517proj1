class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :destroy, :promote, :demote]
  before_filter :correct_user,   only: [:edit, :update, :destroy]
  before_filter :admin_user,     only: [:promote, :demote]

  #show all user
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  #show current user info
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  #create user
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # edit user
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #delete user
  def destroy
    @user = User.find(params[:id])

    if current_user?(@user) && current_user.admin?
      redirect_to root_path, notice: "admin can not delete self"
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to root_url }
        format.json { head :no_content }
      end
    end
  end

  def promote
    respond_to do |format|
      if User.find(params[:id]).update_attribute(:admin, true)
        format.html { redirect_to users_all_path, notice: 'User was successfully promoted to admin.' }
        format.json { head :no_content }
      else
        format.html { redirect_to users_all_path, notice: 'Fail to update user.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  def demote
    respond_to do |format|
      if User.find(params[:id]).update_attribute(:admin, false)
        format.html { redirect_to users_all_path, notice: 'User was successfully demoted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to users_all_path, notice: 'Fail to update user.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def liked
    @user = User.find(params[:id])
    @title = "Posts that #{@user.username} liked"

    render 'show_liked'
  end

  private
    def correct_user
      @user = User.find(params[:id])
      #if the @user != current_user
      #  or if @user.admin != true
      if !current_user?(@user)
        redirect_to root_path, notice: "You do not have the permission to perform this operation" unless current_user.admin?
      end
    end

end
