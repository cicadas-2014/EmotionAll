namespace :cron do
  desc "Start cron task"
  task :start => :environment do
    system("bundle exec whenever --set 'consumer_key=$CONSUMER_KEY&consumer_secret=$CONSUMER_SECRET&access_token=$ACCESS_TOKEN&access_token_secret=$ACCESS_TOKEN_SECRET&alchemy_api=$ALCHEMY_API' --update-crontab emotionall")
  end

  desc "Stop cron tasks"
  task :stop => :environment do
    system('crontab -r')
  end

  desc "List cron tasks"
  task :list => :environment do
    system('crontab -l')
  end
end
