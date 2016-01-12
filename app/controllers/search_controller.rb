class SearchController < ApplicationController

  def index
    authenticate_user
    @fav_cats = InstagramCat.without_soft_destroyed.order(likes: :desc).page(1)
    if user_signed_in?
      @profile = @current_user.image
    end
  end

end
