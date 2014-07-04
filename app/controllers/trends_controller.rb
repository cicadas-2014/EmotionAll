class TrendsController < ApplicationController
	def index
		# looking for tweets from the US
		# each trend has #name, #query, #url, #promoted_content
		@trends = @client.trends(23424977) 
	end
end
