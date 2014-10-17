class DashboardController < ApplicationController
  before_filter :authenticate, :only => [:admin]
  before_action :set_consumers, :only => [:index, :render_partial]
  helper_method :sort_column, :sort_direction, :sort_numeric_column
  
  def index
  end
  
  def cumulative
    entries = TallysheetEntry.includes(:beverage).last(128)
    result = []
    cum_sum = 0
    cum_sum_payed = 0
    entries.each do |e|
      if e.payed
        cum_sum_payed += e.amount
      else
        cum_sum += e.amount
      end
      result.push({:created_at => e.created_at, :cum_sum_payed => cum_sum_payed, :cum_sum => cum_sum})
    end
    render :json => result
  end

  private
  
  def set_consumers
    @consumers = Consumer.includes(tallysheet_entries: [:beverage, :consumer]).order(sort_column + " " + sort_direction).load()
    if sort_numeric_column != nil
      method_name = sort_numeric_column
      dir = sort_direction_numeric
      @consumers = @consumers.sort_by{|e| dir * e.send(method_name)}
    end
  end

  def sort_column
    Consumer.column_names.include?(params[:sort]) ? params[:sort] : "name"
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
