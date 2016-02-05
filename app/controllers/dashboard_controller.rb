class DashboardController < ApplicationController
  before_filter :authenticate, :only => [:login]
  before_action :set_consumers, :only => [:index, :render_partial]
  include Sortable

  def index
  end
  
  def login
    redirect_to root_path
  end
  
  def hourly
    day_tag = "DATE_FORMAT(created_at, '%Y-%j-%H')"
    date_format = "%Y-%j-%H"
    render :json => time_series(1.month, day_tag, date_format)
  end
  
  def weekly
    week_tag = "DATE_FORMAT(created_at, '%Y-%U')"
    date_format = "%Y-%U"
    render :json => time_series(1.year, week_tag, date_format)
  end

  private
  
  def time_series range, sql_tag, date_format
    beverages = Beverage.all
    result = []
    beverages.each do |b|
      entries = TallysheetEntry.select("#{sql_tag} as time, sum(amount) as total_amount").where("beverage_id = ? and created_at >= ?", b.id, (Time.zone.now - range)).group("time")
      if entries.length > 0
        # Create a hash
        result.push({name: b.name, values: Hash[entries.map {|e| [DateTime.strptime(e.time, date_format), e.total_amount]}]})
      end
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
    set_default_sort_column("name")
    @consumers = Consumer.order(sort_column + " " + sort_direction).load()
  end

end
