class SessionsController < ApplicationController
  def new

  end

  def create

    user = User.find_by_user_id(params[:user][:user_id])
    if user
      # valid user

      if user.email.casecmp(params[:user][:email]).zero?
        # email matches
        session[:session_token] = user.session_token
        flash[:notice] = "You're logged in as #{user.user_id}"
        redirect_to root_path
      else
        # login fail with valid username
        flash[:notice] = "Username and Email do not match"
        redirect_to login_path
      end


    else
      flash[:notice] = "Invalid Username and Email"
      redirect_to login_path
    end


  end

  def destroy
    reset_session
    redirect_to movies_path
  end
end
