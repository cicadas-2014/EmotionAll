class AddIndexToTweets < ActiveRecord::Migration
  def change
    add_index :tweets, :text
    add_index :tweets, :country_code
    add_index :tweets, :sentiment
    add_index :tweets, :sentiment_score
    add_index :tweets, :trend_id
  end
end
