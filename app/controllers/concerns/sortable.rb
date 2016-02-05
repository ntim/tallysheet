module Sortable
  extend ActiveSupport::Concern

  included do
    helper_method :sort_column, :sort_direction
  end
  
  def set_default_sort_column name
    if params[:sort] == nil
      params[:sort] = name
    end
  end

  def sort_column
    params[:sort] ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end