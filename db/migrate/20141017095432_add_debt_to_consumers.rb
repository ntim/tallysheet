class AddDebtToConsumers < ActiveRecord::Migration
  def change
    add_column :consumers, :debt, :float, :default => 0
  end
end
