class AddIndexToRakutenCat < ActiveRecord::Migration
  def change
    add_index :rakuten_cats, :code, :unique => true
  end
end
