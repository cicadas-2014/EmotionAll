namespace :stream do
  desc "Start Twitter stream"
  task :start => :environment do
    system('bundle exec rails runner script/tweetstream.rb start')
  end

  desc "Stop Twitter stream"
  task :stop => :environment do
    system('bundle exec rails runner script/tweetstream.rb stop')
  end

  desc "Grab trends/tweets from REST API and restart Twitter stream"
  task :update => :environment do
    system('bundle exec rails runner script/tweetstream.rb stop')
    Trend.current_trends
    Trend.update_tweets
    # Country.new_countries # shouldn't need this anymore after before_create on Tweet model
    Country.update_sentiments # updates the overall sentiment average for every country
    Rails.cache.write('cache', Cache.new)
    system('bundle exec rails runner script/tweetstream.rb start')
  end

  desc "Find daemon pid"
  task :pid => :environment do
    system('cat tracker.pid')
  end
end
