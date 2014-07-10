class Trend < ActiveRecord::Base
	has_many :tweets

	# WOEID (Where On Earth IDentifier) is used by Twitter to define regions of the world
	# defaults to US trends
	def self.current_trends(woeid=23424977)
		new_trends = TwitterService.client.trends(woeid)
		new_trends.each do |trend|
			existing_trend = Trend.find_or_initialize_by(name: trend.name)
			existing_trend.updated_at = Time.now unless existing_trend.new_record?

			if existing_trend.new_record?
				existing_trend.woeid = woeid
				existing_trend.tweet_count = 0
			end

			existing_trend.save
		end
	end

	# default options are recent tweets and english language
	def tweet_search  # gets tweets connected to a trend
		TwitterService.client.search("#{self.name}", lang: "en").attrs[:statuses]
		# in the future, add logic to get a more location-diverse sample of tweets
	end

	def create_tweets
		new_tweets = tweet_search
		new_tweets.select{ |tweet| tweet[:place] != nil }.each do |t|
			unless Tweet.find_by(tweetid: t[:id_str])

				Country.find_or_create_by(country_code: t[:place][:country_code]) # safety measure

				if t[:geo]
					Tweet.create(text: t[:text],
										 	 tweetid: t[:id_str],
								 			 language: t[:lang],
							 				 country_code: t[:place][:country_code],
											 latitude: t[:geo][:coordinates][0],
				 	  					 longitude: t[:geo][:coordinates][1],
					  					 trend: self)
				else
					Tweet.create(text: t[:text],
										 	 tweetid: t[:id_str],
								 			 language: t[:lang],
							 				 country_code: t[:place][:country_code],
					  					 trend: self)
				end
			end
		end
	end

	def update_tweets_sentiments
		self.tweets.each do |t|
			t.analyze_sentiment unless t.sentiment && t.sentiment_score
		end
	end

	def self.most_recent(number=10)
		Trend.order(updated_at: :desc).take(number)
	end

	def self.old_trends
		Trend.order(updated_at: :desc) - Trend.most_recent
	end

	def self.most_popular(number=10)
		Trend.order(tweet_count: :desc).take(number)
	end

	def self.names_array # returns an array to send to Twitter Stream API
		Trend.order(updated_at: :desc).take(30).map(&:name)
	end

	def find_own_tweets
		longest_word = self.name.split(" ").group_by(&:size).max.last.first # doesn't work well for common words like today
		own_tweets = Tweet.where("text ILIKE (?)", "%#{longest_word}%").where(trend: nil)
		own_tweets.each do |t|
			t.update_attributes(trend: self)
		end
	end

	def self.update_tweets
		self.most_recent(30).each do |trend|
			trend.create_tweets # uses REST API to get most recent 100 tweets of a given trend
			trend.find_own_tweets # for tweets that were saved using the Streaming API
			trend.update_tweets_sentiments # makes Alchemy API calls if tweet doesn't have sentiments
			trend.update_attributes(tweet_count: trend.tweets.count)
		end
	end

	def self.map_info(trend_id)
		trend = Trend.find(trend_id)
		tweets = trend.tweets.where("sentiment != 'neutral'").to_a # only care about positive or negative tweets
		country_codes = tweets.map(&:country_code).uniq
		countries = Country.all.to_a
		map_info = []

		country_codes.each do |c|
			country_sentiments = tweets.select{ |t| t.country_code == c }.map(&:sentiment_score)
			country_average = (country_sentiments.inject(:+) / country_sentiments.length).round(2)

			map_info << { code: c,
		        				value: country_average,
		        				overall: countries.select{ |country| country.country_code == c }.first.overall_sentiment || 0.0,
		        				tweet_count: country_sentiments.length }
		end

		map_info
	end

	def world_average
		average = tweets.where("sentiment_score != 0.0 and sentiment_score is not null").pluck(:sentiment_score)

		(average.inject(:+) / average.length).round(2)
	end
end
