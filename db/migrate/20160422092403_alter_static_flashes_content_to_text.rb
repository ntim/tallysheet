class AlterStaticFlashesContentToText < ActiveRecord::Migration
  def change
    change_column :static_flashes, :content, :text
  end
end
