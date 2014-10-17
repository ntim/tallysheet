class AddAmountOfBeveragesToConsumers < ActiveRecord::Migration
  def change
    add_column :consumers, :amount_of_beverages, :integer, :default => 0
  end
end
