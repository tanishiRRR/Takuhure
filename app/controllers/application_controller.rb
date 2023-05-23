class ApplicationController < ActionController::Base

  before_action :set_host

  def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end

end
