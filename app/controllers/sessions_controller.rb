class SessionsController < ApplicationController

  before_action :ensure_not_logged_in, only: [:new, :create]

  def new
    # render text: "FART"
  end

  def create
    username = session_params[:username]
    password = session_params[:password]

    user = User.find_by_credentials(username, password)

    if user.nil?
      flash[:errors] = "wrong password/user combo"
      redirect_to new_sessions_url
    else
      login_user!(user)
    end

  end


  def destroy
    current_user.try(:reset_session_token!)
    session[:token] = nil
    redirect_to cats_url
  end


  private
  def session_params
    params.require(:session).permit(:username, :password, :authenticity_token)
  end

  def ensure_not_logged_in
    flash[:errors] = "Please log out before signing in."
    redirect_to cats_url if !!current_user
  end

end