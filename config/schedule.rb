every 15.minutes do
  job_type :stream_update, "cd :path && RAILS_ENV=production CONSUMER_KEY=:consumer_key CONSUMER_SECRET=:consumer_secret ACCESS_TOKEN=:access_token ACCESS_TOKEN_SECRET=:access_token_secret ALCHEMY_API=:alchemy_api bundle exec rake :task --silent :output"
  stream_update "stream:update", :consumer_Key => @consumer_key, :consumer_secret => @consumer_secret, :access_token => @access_token, :access_token_secret => @access_token_secret
end

