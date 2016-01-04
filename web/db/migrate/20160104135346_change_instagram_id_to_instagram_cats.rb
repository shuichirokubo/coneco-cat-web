class ChangeInstagramIdToInstagramCats < ActiveRecord::Migration
  def up
    change_column :instagram_cats, :instagram_id, :string
  end

  def down
    change_column :instagram_cats, :instagram_id, :integer
  end
end
