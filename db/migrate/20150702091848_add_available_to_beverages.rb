class AddAvailableToBeverages < ActiveRecord::Migration
  def change
    add_column :beverages, :available, :boolean, :default => true
  end
end
