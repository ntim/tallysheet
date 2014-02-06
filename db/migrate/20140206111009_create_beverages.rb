class CreateBeverages < ActiveRecord::Migration
  def change
    create_table :beverages do |t|
      t.text :name
      t.float :price

      t.timestamps
    end
  end
end
