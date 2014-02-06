class Beverage < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true, numericality: true
end
