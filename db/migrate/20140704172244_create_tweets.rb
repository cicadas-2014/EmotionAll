class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.integer :tweetid
      t.integer :retweet_count
      t.string :language
      t.string :country_code
      t.float :longitude
      t.float :latitude
      t.string :sentiment
      t.float :sentiment_score
      t.belongs_to :trend

      t.timestamps
    end
  end
end
