module V1
  class Root < Grape::API
    version 'v1'
    format :json

    helpers do
      def authenticate_error!
        h = {'Access-Control-Allow-Origin' => "*",
             'Access-Control-Request-Method' => %w{GET POST OPTIONS}.join(",")}
        error!('You need to log in to use the app.', 401, h)
      end

      def authenticate_user!
        if cookies[:authHeaders].present?
          auth_cookie = JSON.parse(cookies[:authHeaders])
          params = {
            'uid' => auth_cookie['uid'],
            'access_token' => auth_cookie['access_token'],
            'client_id' => auth_cookie['client_id']
          }
          user = User.find_by_uid(auth_cookie['uid'])
        end
        if user && user.valid_token?(auth_cookie['access_token'], auth_cookie['client_id'])
          @current_user = user
        else
          authenticate_error!
        end
      end
    end

    mount V1::Cats
    mount V1::Favorites
  end
end
