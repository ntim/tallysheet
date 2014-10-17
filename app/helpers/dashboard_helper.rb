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
  
  def total_amount_of_paid_beverages
    consumers = Consumer.all
    total = 0
    consumers.each do |c|
      total += c.amount_of_paid_beverages
    end
    total
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "sortable current #{sort_direction}" : "sortable"
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:controller => "dashboard", :action => "index", :sort => column, :direction => direction}, {:class => css_class}
  end

  def sortable_numeric(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_numeric_column ? "sortable current #{sort_direction}" : "sortable"
    direction = column == sort_numeric_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:controller => "dashboard", :action => "index", :sort_numeric => column, :direction => direction}, {:class => css_class}
  end
end
