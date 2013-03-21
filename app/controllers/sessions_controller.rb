class SessionsController < ApplicationController
  before_filter :signed_in_user, only: [:destroy]

  def new
    if signed_in?
      redirect_to posts_path
    else
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @session }
      end
    end
  end

  def create
    user = User.find_by_email(params[:session][:username_or_email].downcase)
    user = User.find_by_username(params[:session][:username_or_email]) unless user

    #redirect_to controller: 'users', action: 'all'
    respond_to do |format|
      if user && user.authenticate(params[:session][:password])
        #sign in successful redirect to user's show page
        flash.now[:notice] = 'welcome back'
        sign_in user
        format.html { redirect_to posts_path, notice: 'successfully log in.' }
        format.json { render json: user, status: :created, location: @session }
      else
        #sign in fail re-render sign in form and display error
        flash.now[:error] = 'Invalid user and password combination'
        format.html { render action: "new", error: 'Invalid user and password combination' }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
