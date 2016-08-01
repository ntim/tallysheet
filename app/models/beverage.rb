class Beverage < ActiveRecord::Base
  include Monetizable
  
  validates :name, presence: true
  validates :price, presence: true, numericality: true
  
  humanized_money_accessor :price
end
