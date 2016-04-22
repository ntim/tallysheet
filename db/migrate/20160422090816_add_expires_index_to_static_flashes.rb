class AddExpiresIndexToStaticFlashes < ActiveRecord::Migration
  def change
    add_index :static_flashes, :expires
  end
end
