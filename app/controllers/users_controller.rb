class UsersController < ApplicationController

  def new
    # render new_user_url
  end

  def create
    user = User.new(user_params)
    user.password= user_params[:password_digest]

    if user.save!
      login_user!(user)
    else
      flash.now[:errors] = "failed create user"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password_digest, :session_token)
  end

end
