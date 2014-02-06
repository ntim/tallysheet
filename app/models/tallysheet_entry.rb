class TallysheetEntry < ActiveRecord::Base
  belongs_to :consumer
  belongs_to :beverage
  
  validates :consumer_id, presence: true
  validates :beverage_id, presence: true
  validates :amount, presence: true, numericality: true
  
  def price
    self.amount * self.beverage.price
  end
end
