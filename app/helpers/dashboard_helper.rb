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
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    if column == sort_column
      title += " <i class=\"fa fa-sort-alpha-#{sort_direction}\"></i>"
    else
      title += " <i class=\"fa fa-sort\"></i>"
    end
    link_to title.html_safe, {:controller => "dashboard", :action => "index", :sort => column, :direction => direction}
  end

  def sortable_numeric(column, title = nil)
    title ||= column.titleize
    direction = column == sort_numeric_column && sort_direction == "asc" ? "desc" : "asc"
    if column == sort_numeric_column
      title += " <i class=\"fa fa-sort-numeric-#{sort_direction}\"></i>"
    else
      title += " <i class=\"fa fa-sort\"></i>"
    end
    link_to title.html_safe, {:controller => "dashboard", :action => "index", :sort_numeric => column, :direction => direction}
  end
end
