class SessionsController < ApplicationController

  def sign_out
    cookies.delete(:authHeaders)
    redirect_to root_path, flash: { notice: 'ログアウトしました' }
  end

  def sign_in
    auth_hash = {
      'access_token' => params['auth_token'],
      'uid'          => params['uid'],
      'client_id'    => params['client_id'],
      'expiry'       => params['expiry']
    }
    cookies[:authHeaders] = {
      value: auth_hash.to_json,
      expires: 2.week.from_now
    }
    redirect_to root_path, flash: { notice: 'ログインしました' }
  end

end
