namespace :tweet do
  desc 'Update country_id field in Tweet model'
  task :update_country_id => :environment do
    Tweet.where(country_id: nil).each do |t|
      c = Country.find_by(country_code: t.country_code)
      t.update_attributes(country_id: c.id)
      puts "Updated Tweet #{t.id} with Country #{c.country_code}"
    end
    puts '################# FINISHED #################'
  end

  desc 'Clean up old Tweets with no sentiment score'
  task :delete_nil_sentiment_tweets => :environment do
  	Tweet.delete_all(["sentiment_score IS NULL AND created_at < :week", {:week => 1.week.ago}])
  end
end