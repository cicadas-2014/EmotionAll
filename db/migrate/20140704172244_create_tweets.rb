class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.string :tweetid
      t.integer :retweet_count
      t.string :language
      t.string :country_code
      t.float :latitude
      t.float :longitude
      t.string :sentiment, default: "neutral"
      t.float :sentiment_score, default: 0
      t.belongs_to :trend

      t.timestamps
    end
  end
end
