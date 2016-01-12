class SearchController < ApplicationController

  def index
    authenticate_user
    @fav_cats = InstagramCat.without_soft_destroyed.order(likes: :desc).page(1)
    if user_signed_in?
      @profile = @current_user.image
      @fav_flg = {}
      @fav_cats.each do |fav_cat|
        @fav_flg[fav_cat[:id]] = Favorite.exists?(:cat_id => fav_cat[:id], :user_id => @current_user.id)
      end
    end
  end

end
