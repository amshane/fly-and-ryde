class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  # client = Uber::Client.new do |config|
  #   config.server_token  = ENV["UBER_SERVER_TOKEN"]
  #   config.client_id     = ENV["UBER_CLIENT_ID"]
  #   config.client_secret = ENV["UBER_CLIENT_SECRET"]
  # end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end
end
