require 'rails_helper'

RSpec.describe "tweets/edit", :type => :view do
  before(:each) do
    @tweet = assign(:tweet, Tweet.create!(
      :tweet => "MyString",
      :tweetid => 1,
      :retweet_count => 1,
      :language => "MyString",
      :country_code => "MyString",
      :longitude => 1.5,
      :latitude => 1.5,
      :sentiment => "MyString",
      :sentiment_score => 1.5,
      :trend_id => 1
    ))
  end

  it "renders the edit tweet form" do
    render

    assert_select "form[action=?][method=?]", tweet_path(@tweet), "post" do

      assert_select "input#tweet_tweet[name=?]", "tweet[tweet]"

      assert_select "input#tweet_tweetid[name=?]", "tweet[tweetid]"

      assert_select "input#tweet_retweet_count[name=?]", "tweet[retweet_count]"

      assert_select "input#tweet_language[name=?]", "tweet[language]"

      assert_select "input#tweet_country_code[name=?]", "tweet[country_code]"

      assert_select "input#tweet_longitude[name=?]", "tweet[longitude]"

      assert_select "input#tweet_latitude[name=?]", "tweet[latitude]"

      assert_select "input#tweet_sentiment[name=?]", "tweet[sentiment]"

      assert_select "input#tweet_sentiment_score[name=?]", "tweet[sentiment_score]"

      assert_select "input#tweet_trend_id[name=?]", "tweet[trend_id]"
    end
  end
end
