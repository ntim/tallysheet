class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :exception
  helper_method :rendering_time
  before_filter :set_rendering_start_time, :set_default_url_options_host
  def rendering_time
    millis = (Time.now.usec - @rendering_start_time).abs / 1000.0
    "Rendered in %d ms" % millis
  end

  def login
    authenticate
    respond_to do |format|
      format.html { redirect_to request.referer.present? ? :back : root_path }
      format.text { head :no_content }
    end
  end

  private

  def authenticate
    session[:authenticated] = authenticate_or_request_with_http_basic do |username, password|
      username == "tally" && password == "sheet!"
    end
    session[:authenticated]
  end

  def set_rendering_start_time
    @rendering_start_time = Time.now.usec
  end

  def set_default_url_options_host
    if request != nil
      Rails.application.routes.default_url_options[:host] = request.host_with_port
    end
  end
end
