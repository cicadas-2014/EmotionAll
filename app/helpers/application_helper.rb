module ApplicationHelper
	def get_client
		Twitter::REST::Client.new do |config|
			config.consumer_key        = Rails.application.secrets.consumer_key
			config.consumer_secret     = Rails.application.secrets.consumer_secret
			config.access_token        = Rails.application.secrets.oauth_token
			config.access_token_secret = Rails.application.secrets.oauth_token_secret
		end
	end
end
