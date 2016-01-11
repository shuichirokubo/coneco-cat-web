module V1
  class Favorites < Grape::API
    resource :favorites do

      desc 'Register favorite cat.'
      params do
        requires :cat_id, type: Integer, desc: 'Cat ID'
      end
      get do
        authenticate_user!
        Favorite.find_or_create_by(user_id: @current_user.id, cat_id: params[:cat_id]) do |favorite|
          favorite.save!
        end
        status 201
      end

    end
  end
end
