class CreateStaticFlashes < ActiveRecord::Migration
  def change
    create_table :static_flashes do |t|
      t.datetime :expires
      t.string :content

      t.timestamps null: false
    end
  end
end
