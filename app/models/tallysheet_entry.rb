class TallysheetEntry < ActiveRecord::Base
  belongs_to :consumer
  belongs_to :beverage

  validates :consumer_id, presence: true
  validates :beverage_id, presence: true
  validates :amount, presence: true, numericality: true
  def price
    if self.beverage == nil
      nil
    else
      self.amount * self.beverage.price
    end
  end
  
  after_create do
    self.consumer.dept += price
    self.consumer.amount_of_beverages += self.amount
    self.consumer.save  
  end
  
  before_destroy do
    self.consumer.dept -= price
    self.consumer.amount_of_beverages -= self.amount
    self.consumer.save    
  end
  
  after_update do
    self.consumer.update_derived
  end
end
