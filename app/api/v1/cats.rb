module V1
  class Cats < Grape::API
    resource :cats do

      desc 'Return all cats.'
      params do
        optional :page, type: Integer, desc: 'Page Num'
      end
      get do
        cats = InstagramCat.all.without_soft_destroyed.page(params[:page])
        cats.each do |cat|
          cat[:text].force_encoding('UTF-8')
          cat[:tags].force_encoding('UTF-8')
        end
        cats
      end

      desc 'Return fav_count ranking cats.'
      params do
        optional :page, type: Integer, desc: 'Page Num'
      end
      get 'ranking' do
        cats = InstagramCat.without_soft_destroyed.order(fav_count: :desc).page(params[:page])
        cats.each do |cat|
          cat[:text].force_encoding('UTF-8')
          cat[:tags].force_encoding('UTF-8')
        end
        cats
      end

      desc 'Return like_count ranking cats.'
      params do
        optional :page, type: Integer, desc: 'Page Num'
      end
      get 'like' do
        cats = InstagramCat.without_soft_destroyed.order(likes: :desc).page(params[:page])
        cats.each do |cat|
          cat[:text].force_encoding('UTF-8')
          cat[:tags].force_encoding('UTF-8')
        end
        cats
      end

    end
  end
end
