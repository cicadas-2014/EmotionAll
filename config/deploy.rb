set :whenever_command, "whenever --set 'consumer_key=$CONSUMER_KEY&consumer_secret=$CONSUMER_SECRET&access_token=$ACCESS_TOKEN&access_token_secret=$ACCESS_TOKEN_SECRET&alchemy_api=$ALCHEMY_API' --update-crontab"
require "whenever/capistrano"
