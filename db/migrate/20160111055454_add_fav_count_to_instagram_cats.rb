class AddFavCountToInstagramCats < ActiveRecord::Migration
  def change
    add_column :instagram_cats, :fav_count, :integer, :after => :userpic, :default => 0
  end
end
