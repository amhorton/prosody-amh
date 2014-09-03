class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_user_id_or_false

  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def current_user_id_or_false
    return current_user.id if !!current_user
    false
  end


  def sign_in_user(user)
    session[:token] = user.session_token
  end

  def sign_out
    current_user.reset_session_token
    @current_user = nil
    session[:token] = nil
  end

  def signed_in?
    !!current_user
  end

  def signed_in_check
    redirect_to new_session_url unless signed_in?
  end
end
