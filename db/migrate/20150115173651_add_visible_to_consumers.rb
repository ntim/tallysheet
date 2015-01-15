class AddVisibleToConsumers < ActiveRecord::Migration
  def change
    add_column :consumers, :visible, :boolean, :default => true
  end
end
