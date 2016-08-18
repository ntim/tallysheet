class Payment < ActiveRecord::Base
  belongs_to :consumer

  after_create do
    Redis.new.publish "active_record", {:payment => {:create => self}}.to_json
  end
end
