class CreateConsumers < ActiveRecord::Migration
  def change
    create_table :consumers do |t|
      t.text :name
      t.text :email
      t.float :credit, :default => 0

      t.timestamps
    end
  end
end
