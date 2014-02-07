module DashboardHelper
  def total_debt
    consumers = Consumer.all
    total = 0
    consumers.each do |c|
      total += c.debt
    end
    total
  end
  
  def total_amount_of_beverages
    consumers = Consumer.all
    total = 0
    consumers.each do |c|
      total += c.amount_of_beverages
    end
    total
  end
  
  def total_amount_of_payed_beverages
    consumers = Consumer.all
    total = 0
    consumers.each do |c|
      total += c.amount_of_payed_beverages
    end
    total
  end
    
end
