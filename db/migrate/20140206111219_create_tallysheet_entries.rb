class CreateTallysheetEntries < ActiveRecord::Migration
  def change
    create_table :tallysheet_entries do |t|
      t.references :consumer, index: true
      t.references :beverage, index: true
      t.integer :amount, :default => 1
      t.boolean :payed

      t.timestamps
    end
  end
end
