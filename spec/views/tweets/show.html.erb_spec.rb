require 'rails_helper'

RSpec.describe "tweets/show", :type => :view do
  before(:each) do
    @tweet = assign(:tweet, Tweet.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Tweet/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Language/)
    expect(rendered).to match(/Country Code/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/Sentiment/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/3/)
  end
end
