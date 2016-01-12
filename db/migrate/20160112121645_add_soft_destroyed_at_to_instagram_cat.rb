class AddSoftDestroyedAtToInstagramCat < ActiveRecord::Migration
  def change
    add_column :instagram_cats, :soft_destroyed_at, :datetime
    add_index :instagram_cats, :soft_destroyed_at
  end
end
