class DashboardController < ApplicationController
  before_filter :authenticate, :only => [:login]
  before_action :set_consumers, :only => [:index, :render_partial]
  helper_method :sort_column, :sort_direction, :sort_numeric_column
  def index
  end
  
  def login
    redirect_to root_path
  end

  # Deprecated
  def cumulative
    beverages = Beverage.all
    result = []
    beverages.each do |b|
      values = []
      cum_sum = 0
      entries = TallysheetEntry.where("beverage_id = ? and created_at >= ?", b.id, (Time.zone.now - 1.month)).order("id ASC")
      entries.each do |e|
        cum_sum += e.amount
        if values.size > 0 && values[-1][:time] == e.created_at.to_i
          values[-1][:cum_sum] = cum_sum
        else
          values.push({time: e.created_at.to_i, cum_sum: cum_sum})
        end
      end
      if entries.size > 0
        result.push({name: b.name, values: values})
      end
    end
    render :json => result
  end
  
  def weekly
    week_tag = Rails.env.development? ? "strftime(\"%Y-%W\", created_at)" : "DATE_FORMAT(created_at, '%Y-%u')"
    beverages = Beverage.all
    result = []
    beverages.each do |b|
      entries = TallysheetEntry.select("#{week_tag} as time, sum(amount) as total_amount").where("beverage_id = ? and created_at >= ?", b.id, (Time.zone.now - 1.month)).group("time")
      # Create a hash
      result.push({name: b.name, values: Hash[entries.map {|e| [DateTime.strptime(e.time, '%Y-%W'), e.total_amount]}]})
    end
    # Insert missing data.
    all = result.map {|b| b[:values].keys}.flatten.uniq
    all = Hash[all.map {|a| [a, 0]}]
    result.each do |r|
      r[:values] = all.merge(r[:values])
    end
    #
    render :json => result
  end

  private

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
