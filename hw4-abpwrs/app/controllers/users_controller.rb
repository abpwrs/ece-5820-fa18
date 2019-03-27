class UsersController < ApplicationController
  def user_params
    params.require(:user).permit(:user_id, :email)
  end

  def new
    # default: render 'new' template
  end

  def create
    begin
      @user = User.create_user(user_params)
      flash[:notice] = "Welcome #{@user.user_id}. Your account has been created."
      redirect_to login_path
    rescue ActiveRecord::RecordInvalid
      flash[:warning] = "Sorry, This User ID is taken. Please try another"
      redirect_to new_user_path
    end
  end

end
