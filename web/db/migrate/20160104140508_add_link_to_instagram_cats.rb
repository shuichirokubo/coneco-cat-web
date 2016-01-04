class AddLinkToInstagramCats < ActiveRecord::Migration
  def change
    add_column :instagram_cats, :link, :string
  end
end
