class CreateRakutenCats < ActiveRecord::Migration
  def change
    create_table :rakuten_cats do |t|
      t.string :code
      t.string :name
      t.integer :price
      t.string :afl_url
      t.string :image_url
      t.string :catchcopy
      t.string :caption
      t.integer :review_average
      t.integer :review_count

      t.timestamps null: false
    end
  end
end
