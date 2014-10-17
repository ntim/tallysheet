class Consumer < ActiveRecord::Base
  has_many :tallysheet_entries
  
  def derive_amount_of_paid_beverages
    amount = 0
    self.tallysheet_entries.each do |e|
      if e.payed
        amount += e.amount
      end
    end
    amount
  end
  
  def derive_amount_of_beverages
    amount = 0
    self.tallysheet_entries.each do |e|
      if !e.payed
        amount += e.amount
      end
    end
    amount
  end
  
  def derive_debt
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
    self.credit = amount - self.derive_debt
    self.tallysheet_entries.each do |e|
      e.payed = true
      e.save
    end
    self.debt = -self.credit
    self.amount_of_paid_beverages += self.amount_of_beverages
    self.amount_of_beverages = 0
    self.save
  end
  
  def update_derived
    self.debt = self.derive_debt
    self.amount_of_beverages = self.derive_amount_of_beverages
    self.amount_of_paid_beverages = self.derive_amount_of_paid_beverages
    self.save
  end
  
  validates :name, presence: true
  validates :email, presence: true, email: true
  validates :credit, numericality: true
end
