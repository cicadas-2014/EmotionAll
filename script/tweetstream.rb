require 'tweetstream'

ENV["RAILS_ENV"] ||= "production"

TweetStream.configure do |config|
	config.consumer_key       = ENV['CONSUMER_KEY']
	config.consumer_secret    = ENV['CONSUMER_SECRET']
	config.oauth_token        = ENV['ACCESS_TOKEN']
	config.oauth_token_secret = ENV['ACCESS_TOKEN_SECRET']
	config.auth_method        = :oauth
end

daemon = TweetStream::Daemon.new('tracker', :log_output => false) # change to true for debugging

daemon.on_inited do
	ActiveRecord::Base.connection.reconnect!
end

daemon.track(Trend.names_array) do |t|
	# only care about tweets with a place object to get the country code
	# tweets don't inherently know what trend they belong to, so use Trend#find_own_tweets
	unless Tweet.find_by(tweetid: t.attrs[:id_str]) # still need this because of tweets gathered from REST API
		if t.place? && t.lang == 'en'
			if t.geo?
				Tweet.create(text: t.text,
										 tweetid: t.attrs[:id_str],
					  				 language: t.lang,
					  				 country_code: t.place.country_code,
					  				 latitude: t.geo.coordinates[0],
					  				 longitude: t.geo.coordinates[1])
			else
				Tweet.create(text: t.text,
						  			 tweetid: t.attrs[:id_str],
						  			 language: t.lang,
						  			 country_code: t.place.country_code)
			end
		end
	end
end