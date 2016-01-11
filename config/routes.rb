Rails.application.routes.draw do

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get 'welcome/index'
  get 'welcome/show'

  # For APIs
  Rails.application.routes.draw do
    mount API => '/'
  end

  mount_devise_token_auth_for 'User', at: 'api/v1/auth'

  # Account management
  delete '/logout', to: 'sessions#sign_out'
  get '/login', to: 'sessions#sign_in'

end
