class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :consumer, index: true
      t.float :amount

      t.timestamps null: false
    end
    add_foreign_key :payments, :consumers
  end
end
