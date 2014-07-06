TweetStream.configure do |config|
	config.consumer_key       = Rails.application.secrets.consumer_key
	config.consumer_secret    = Rails.application.secrets.consumer_secret
	config.oauth_token        = Rails.application.secrets.oauth_token
	config.oauth_token_secret = Rails.application.secrets.oauth_token_secret
	config.auth_method        = :oauth
end

ENV["RAILS_ENV"] ||= "production"

root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
require File.join(root, "config", "environment")

daemon = TweetStream::Daemon.new('tracker', :log_output => true)

daemon.on_inited do
	ActiveRecord::Base.connection.reconnect!
	ActiveRecord::Base.logger = Logger.new(File.open('log/stream.log', 'w+'))
end

daemon.track(Trend.most_recent_names_array) do |t|
	unless Tweet.find_by(tweetid: t.attrs[:id_str]) # can possibly remove this since stream is live
  	if t.geo? # only care about tweets with a geolocation or place object
			Tweet.create(text: t.text,
									 tweetid: t.attrs[:id_str],
				  				 retweet_count: t.retweet_count,
				  				 language: t.lang,
				  				 country_code: t.place.country_code,
				  				 latitude: t.geo.coordinates[0],
				  				 longitude: t.geo.coordinates[1]) # tweets don't inherently know what trend they belong to
		elsif t.place?							# use Trend#find_own_tweets
			Tweet.create(text: t.text,
					  			 tweetid: t.attrs[:id_str],
					  			 retweet_count: t.retweet_count,
					  			 language: t.lang,
					  			 country_code: t.place.country_code)
		end
	end
end

	# @client = TweetStream::Client.new
# @client.track(['bieber','Happy 5th of July']) do |t| puts "#{t.text} #{t.geo.coordinates}"  end
# @client.locations('-180,-90,180,90') do |t| puts t.place.full_name end