class SessionsController < ApplicationController
  def index
    if session[:user_id]!=nil
      redirect_to home_path
    end
    @error_msg = nil
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      session[:user_type] = user.usertype
      @user = User.find(session[:user_id])
      @error_msg = nil
      redirect_to root_path
    else
      flash.now.alert = 'Login failed, please try again.'
      @error_msg = 'Wrong username or password'
      render :index
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_type] = nil
    redirect_to root_url
  end
end
