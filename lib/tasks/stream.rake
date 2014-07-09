namespace :stream do
  desc "Start Twitter stream"
  task :start => :environment do
    exec('bundle exec rails runner script/tweetstream.rb start')
  end

  desc "Stop Twitter stream"
  task :stop => :environment do
    exec('bundle exec rails runner script/tweetstream.rb stop')
  end

  desc "Grab trends/tweets from REST API and restart Twitter stream"
  task :update => :environment do
    system('bundle exec rails runner script/tweetstream.rb stop')
    Trend.current_trends
    Trend.update_tweets
    Country.new_countries
    Country.update_sentiments # updates the overall sentiment average for every country
    Rails.cache.write('cache', Cache.new)
    system('bundle exec rails runner script/tweetstream.rb start')
  end
end
