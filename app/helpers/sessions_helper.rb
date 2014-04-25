module SessionsHelper

  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def login_user!(user)
    p current_user
    if current_user.nil? || current_user.user_name != user.user_name
      @current_user = user
      session[:token] = @current_user.reset_session_token!
    # else
    #
    end

    redirect_to cats_url
  end

end
