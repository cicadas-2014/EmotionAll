require 'rails_helper'

RSpec.describe "tweets/index", :type => :view do
  before(:each) do
    assign(:tweets, [
      Tweet.create!(
        :tweet => "Tweet",
        :tweetid => 1,
        :retweet_count => 2,
        :language => "Language",
        :country_code => "Country Code",
        :longitude => 1.5,
        :latitude => 1.5,
        :sentiment => "Sentiment",
        :sentiment_score => 1.5,
        :trend_id => 3
      ),
      Tweet.create!(
        :tweet => "Tweet",
        :tweetid => 1,
        :retweet_count => 2,
        :language => "Language",
        :country_code => "Country Code",
        :longitude => 1.5,
        :latitude => 1.5,
        :sentiment => "Sentiment",
        :sentiment_score => 1.5,
        :trend_id => 3
      )
    ])
  end

  it "renders a list of tweets" do
    render
    assert_select "tr>td", :text => "Tweet".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
    assert_select "tr>td", :text => "Country Code".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Sentiment".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
