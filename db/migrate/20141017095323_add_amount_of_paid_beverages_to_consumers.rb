class AddAmountOfPaidBeveragesToConsumers < ActiveRecord::Migration
  def change
    add_column :consumers, :amount_of_paid_beverages, :integer, :default => 0
  end
end
