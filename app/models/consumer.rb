class Consumer < ActiveRecord::Base
  include Monetizable
  
  has_many :tallysheet_entries
  has_many :payments, :dependent => :destroy

  validates :name, presence: true
  validates :email, presence: true, email: true
  validates :credit, numericality: true
  
  humanized_money_accessor :credit, :debt
  
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
    amount -= self.credit
    amount
  end

  def pay amount
    self.credit = amount - self.derive_debt
    self.tallysheet_entries.each do |e|
    # Skip tallysheet entry callback.
      if !e.payed
        e.update_columns(:payed => true)
      end
    end
    self.debt = -self.credit
    self.amount_of_paid_beverages += self.amount_of_beverages
    self.amount_of_beverages = 0
    self.save
    #
    Payment.create({consumer: self, amount: amount})
  end

  def transfer recipient, amount
    self.pay -amount
    recipient.pay amount
  end

  def update_derived
    Rails.logger.info "update_derived for consumer " + self.id.to_s
    self.debt = self.derive_debt
    self.amount_of_beverages = self.derive_amount_of_beverages
    self.amount_of_paid_beverages = self.derive_amount_of_paid_beverages
    self.save
  end

  def destroyable?
    self.amount_of_paid_beverages == 0 && self.amount_of_beverages == 0 && self.debt == 0
  end

  after_create do
    Redis.new.publish "active_record", {:consumer => {:create => self}}.to_json(:except=> [:email])
  end

  after_update do
    Redis.new.publish "active_record", {:consumer => {:update => self}}.to_json(:except=> [:email])
  end

  before_destroy do
    if destroyable?
      Redis.new.publish "active_record", {:consumer => {:destroy => self}}.to_json(:except=> [:email])
    end
    destroyable?
  end

end
