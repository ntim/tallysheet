class Consumer < ActiveRecord::Base
  has_many :tallysheet_entries
  
  def amount_of_payed_beverages
    amount = 0
    self.tallysheet_entries.each do |e|
      if e.payed
        amount += e.amount
      end
    end
    amount
  end
  
  def amount_of_beverages
    amount = 0
    self.tallysheet_entries.each do |e|
      if !e.payed
        amount += e.amount
      end
    end
    amount
  end
  
  def debt
    amount = 0
    self.tallysheet_entries.each do |e|
      if !e.payed
        amount += e.price
      end
    end
    amount -= credit
    amount
  end
  
  def pay amount
    self.credit = amount - self.debt
    self.tallysheet_entries.each do |e|
      e.payed = true
      e.save
    end
    self.save
  end
  
  validates :name, presence: true
  validates :email, presence: true, email: true
  validates :credit, numericality: true
end
