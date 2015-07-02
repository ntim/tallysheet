class DashboardController < ApplicationController
  before_filter :authenticate, :only => [:login]
  before_action :set_consumers, :only => [:index, :render_partial]
  helper_method :sort_column, :sort_direction, :sort_numeric_column
  def index
  end
  
  def login
    redirect_to root_path
  end
  
  def daily
    day_tag = Rails.env.development? ? "strftime(\"%Y-%j\", created_at)" : "DATE_FORMAT(created_at, '%Y-%j')"
    date_format = "%Y-%j"
    render :json => time_series(1.month, day_tag, date_format)
  end
  
  def weekly
    week_tag = Rails.env.development? ? "strftime(\"%Y-%W\", created_at)" : "DATE_FORMAT(created_at, '%Y-%u')"
    date_format = "%Y-%W"
    render :json => time_series(1.year, week_tag, date_format)
  end

  private
  
  def time_series range, sql_tag, date_format
    beverages = Beverage.all
    result = []
    beverages.each do |b|
      entries = TallysheetEntry.select("#{sql_tag} as time, sum(amount) as total_amount").where("beverage_id = ? and created_at >= ?", b.id, (Time.zone.now - range)).group("time")
      # Create a hash
      result.push({name: b.name, values: Hash[entries.map {|e| [DateTime.strptime(e.time, date_format), e.total_amount]}]})
    end
    # Insert missing data.
    all = result.map {|b| b[:values].keys}.flatten.uniq
    all = Hash[all.map {|a| [a, 0]}]
    result.each do |r|
      r[:values] = all.merge(r[:values])
    end
    return result
  end

  def set_consumers
    if sort_numeric_column != nil
      @consumers = Consumer.all()
      method_name = sort_numeric_column
      dir = sort_direction_numeric
      @consumers = @consumers.sort_by{|e| dir * e.send(method_name)}
    else
      @consumers = Consumer.order(sort_column + " " + sort_direction).load()
    end
  end

  def sort_column
    Consumer.column_names.include?(params[:sort]) ? params[:sort] : params[:sort_numeric] != nil ? "" : "name"
  end

  def sort_numeric_column
    params[:sort_numeric] != nil && Consumer.new.respond_to?(params[:sort_numeric]) ? params[:sort_numeric] : nil
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_direction_numeric
    params[:direction] == "asc" ? 1 : -1
  end

end
