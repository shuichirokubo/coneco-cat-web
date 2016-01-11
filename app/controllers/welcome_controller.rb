class WelcomeController < ApplicationController

  def index
    authenticate_user
    if user_signed_in?
      #@graph = Koala::Facebook::API.new(current_user.oauth_token)
      @profile = @current_user.image
      @cats = InstagramCat.all.page(1)
    end
  end

  def show
  end

end
