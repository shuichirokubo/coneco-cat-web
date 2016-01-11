class AboutController < ApplicationController

  def index
    authenticate_user
    @profile = @current_user.image if user_signed_in?
  end

end
