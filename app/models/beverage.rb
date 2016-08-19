class Beverage < ActiveRecord::Base
  include Monetizable
  
  validates :name, presence: true
  validates :price, presence: true, numericality: true
  
  humanized_money_accessor :price

  after_create do
    Redis.new.publish "active_record", {:beverage => {:create => self}}.to_json
  end

  after_update do
    Redis.new.publish "active_record", {:beverage => {:update => self}}.to_json
  end

  before_destroy do
    Redis.new.publish "active_record", {:beverage => {:destroy => self}}.to_json
  end

end
