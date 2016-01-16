class RankingController < ApplicationController

  def index
    authenticate_user
    @fav_cats = InstagramCat.without_soft_destroyed.order(fav_count: :desc).page(1).per(30)
    @profile = @current_user.image if user_signed_in?
  end

end
