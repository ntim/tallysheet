class DashboardController < ApplicationController
  
  def index
    @consumers = Consumer.includes(:tallysheet_entries).all()
  end
  
end
