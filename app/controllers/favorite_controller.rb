class FavoriteController < ApplicationController

  def index
    authenticate_user
    @fav_cats = []
    Favorite.where(user_id: @current_user.id).page(1).each do |favorite|
      fav_cat = InstagramCat.without_soft_destroyed.where(id: favorite.cat_id).first
      @fav_cats.push(fav_cat)
    end
    if user_signed_in?
      @profile = @current_user.image
    end
  end

end
