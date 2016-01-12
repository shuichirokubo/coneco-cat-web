class SearchController < ApplicationController

  def index
    authenticate_user
    @fav_cats = InstagramCat.order(likes: :desc).page(1)
    if user_signed_in?
      @profile = @current_user.image
    end
  end

end
