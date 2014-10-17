class UpdateDerivedForConsumers < ActiveRecord::Migration
  def change
    consumers = Consumer.includes(:tallysheet_entries).all
    consumers.each do |c|
      c.update_derived
    end
  end
end
