class DashboardController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def index
    @consumers = Consumer.order(sort_column + " " + sort_direction).all()
  end

  private

  def sort_column
    params[:sort] != nil ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
