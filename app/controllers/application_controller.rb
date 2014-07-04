class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_client

  def load_client
    @client = Twitter::REST::Client.new do |config|
		 	  	config.consumer_key        = Rails.application.secrets.consumer_key
		 	  	config.consumer_secret     = Rails.application.secrets.consumer_secret
		 	  	config.access_token        = Rails.application.secrets.oauth_token
		 	  	config.access_token_secret = Rails.application.secrets.oauth_token_secret
			  end
  end
end
