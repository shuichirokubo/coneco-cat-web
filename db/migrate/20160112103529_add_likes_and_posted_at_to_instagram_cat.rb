class AddLikesAndPostedAtToInstagramCat < ActiveRecord::Migration
  def change
    add_column :instagram_cats, :likes, :integer, :default => 0, :after => :fav_count
    add_column :instagram_cats, :posted_at, :datetime
  end
end
