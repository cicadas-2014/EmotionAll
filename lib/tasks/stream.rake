namespace :stream do
  desc "Start Twitter stream"
  task :start => :environment do
    exec('bundle exec ruby script/tweetstream.rb start')
  end

  desc "Stop Twitter stream"
  task :stop => :environment do
    exec('bundle exec ruby script/tweetstream.rb stop')
  end
end
