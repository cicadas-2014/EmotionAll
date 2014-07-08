# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
every 30.minutes do
  job_type :stream_update, "cd :path && RAILS_ENV=production CONSUMER_KEY=:consumer_key CONSUMER_SECRET=:consumer_secret ACCESS_TOKEN=:access_token ACCESS_TOKEN_SECRET=:access_token_secret ALCHEMY_API=:alchemy_api bundle exec rake :task --silent :output"
  stream_update "stream:update", :consumer_Key => @consumer_key, :consumer_secret => @consumer_secret, :access_token => @access_token, :access_token_secret => @access_token_secret
end

# whenever --set "consumer_key=$CONSUMER_KEY&consumer_secret=$CONSUMER_SECRET&access_token=$ACCESS_TOKEN&access_token_secret=$ACCESS_TOKEN_SECRET&alchemy_api=$ALCHEMY_API" --update-crontab
