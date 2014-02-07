class DashboardController < ApplicationController
  before_filter :authenticate, :only => [:admin]
  helper_method :sort_column, :sort_direction, :sort_numeric_column
  def index
    @consumers = Consumer.includes(:tallysheet_entries).order(sort_column + " " + sort_direction).all()
    if sort_numeric_column != nil
      method_name = sort_numeric_column
      dir = sort_direction_numeric
      @consumers = @consumers.sort_by{|e| dir * e.send(method_name)}
    end
  end
  
  def admin
  end

  private

  def sort_column
    Consumer.column_names.include?(params[:sort]) ? params[:sort] : "id"
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
