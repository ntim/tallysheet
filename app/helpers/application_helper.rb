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
end
