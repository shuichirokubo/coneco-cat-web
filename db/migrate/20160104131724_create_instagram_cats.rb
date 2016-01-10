class CreateInstagramCats < ActiveRecord::Migration
  def change
    create_table :instagram_cats do |t|
      t.integer :instagram_id
      t.string :text
      t.string :image_url
      t.string :tags
      t.integer :userid
      t.string :username
      t.string :userpic

      t.timestamps null: false
    end
  end
end
