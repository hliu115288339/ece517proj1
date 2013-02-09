class SessionsController < ApplicationController
  # GET /sessions
  # GET /sessions.json
  #def index
  #  @sessions = Session.all
  #
  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.json { render json: @sessions }
  #  end
  #end

  # GET /sessions/1
  # GET /sessions/1.json
  #def show
  #  @session = Session.find(params[:id])
  #
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.json { render json: @session }
  #  end
  #end

  # GET /sessions/new
  # GET /sessions/new.json
  def new
    #@session = Session.new
    if signed_in?
      redirect_to posts_path
    else
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @session }
      end
    end
  end

  # GET /sessions/1/edit
  #def edit
  #  @session = Session.find(params[:id])
  #end

  # POST /sessions
  # POST /sessions.json
  def create
    user = User.find_by_email(params[:session][:username_or_email].downcase)
    if !user
      user = User.find_by_username(params[:session][:username_or_email])
    end

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

  # PUT /sessions/1
  # PUT /sessions/1.json
  #def update
  #  @session = Session.find(params[:id])
  #
  #  respond_to do |format|
  #    if @session.update_attributes(params[:session])
  #      format.html { redirect_to @session, notice: 'Session was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: "edit" }
  #      format.json { render json: @session.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    sign_out
    redirect_to root_url
  end
end
