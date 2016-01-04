class AddIndexToInstagramCat < ActiveRecord::Migration
  def change
    add_index :instagram_cats, :instagram_id, :unique => true
  end
end
