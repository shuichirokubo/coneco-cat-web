class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_error!
  end

  def authenticate_user
    return { 'success' => false } if cookies[:authHeaders].blank?
    auth_cookie = JSON.parse(cookies[:authHeaders])
    user = User.find_by_uid(auth_cookie['uid'])
    @current_user = user if user && user.valid_token?(auth_cookie['access_token'], auth_cookie['client_id'])
  end

end
