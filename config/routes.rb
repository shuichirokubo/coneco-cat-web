Rails.application.routes.draw do

  get 'favorite', to: 'favorite#index'
  get 'favorite/index'

  get 'search', to: 'search#index'
  get 'search/index'

  get 'about', to: 'about#index'
  get 'about/index'

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get 'welcome', to: 'welcome#index'
  get 'welcome/index'
  get 'welcome/show'

  # For APIs
  Rails.application.routes.draw do
  get 'favorite/index'

  get 'search/index'

    mount API => '/'
  end

  mount_devise_token_auth_for 'User', at: 'api/v1/auth'

  # Account management
  get 'logout', to: 'sessions#sign_out'
  delete 'logout', to: 'sessions#sign_out'
  get 'login', to: 'sessions#sign_in'

end
