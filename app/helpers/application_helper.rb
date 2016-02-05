module ApplicationHelper
  def style_debt value
    if value <= 0
      ('<span style="color:green">%.2f &euro;</span>' % value).html_safe
    else
    ('<span style="color:red">%.2f &euro;</span>' % value).html_safe
    end
  end

  def style_credit value
    if value >= 0
      ('<span style="color:green">%.2f &euro;</span>' % value).html_safe
    else
    ('<span style="color:red">%.2f &euro;</span>' % value).html_safe
    end
  end

  def numeric?(object)
    true if Float(object) rescue false
  end

  def flash_class(level)
    case level
    when "notice" then "alert alert-info"
    when "success" then "alert alert-success"
    when "error" then "alert alert-danger"
    when "alert" then "alert alert-danger"
    else level.to_s
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    if column == sort_column
      title += " <i class=\"fa fa-sort-alpha-#{sort_direction}\"></i>"
    else
      title += " <i class=\"fa fa-sort\"></i>"
    end
    link_to title.html_safe, {:controller => controller_name, :action => action_name, :sort => column, :direction => direction}
  end

  def sortable_amount(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    if column == sort_column
      title += " <i class=\"fa fa-sort-amount-#{sort_direction}\"></i>"
    else
      title += " <i class=\"fa fa-sort\"></i>"
    end
    link_to title.html_safe, {:controller => controller_name, :action => action_name, :sort => column, :direction => direction}
  end

  def sortable_numeric(column, title = nil)
    title ||= column.titleize
    direction = column == sort_numeric_column && sort_direction == "asc" ? "desc" : "asc"
    if column == sort_numeric_column
      title += " <i class=\"fa fa-sort-numeric-#{sort_direction}\"></i>"
    else
      title += " <i class=\"fa fa-sort\"></i>"
    end
    link_to title.html_safe, {:controller => controller_name, :action => action_name, :sort_numeric => column, :direction => direction}
  end
end
