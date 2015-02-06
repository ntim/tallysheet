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
end
