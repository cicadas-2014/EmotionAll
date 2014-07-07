require 'rails_helper'
require 'spec_helper'

describe Tweet do
  context "associations" do
    it { should belong_to :trend }
  end
end


describe "Tweet model methods" do
     before(:each) do
         @tweet = Tweet.create(text: "MyString",
	    tweetid: 1,
	    retweet_count: 1,
	    language: "MyString",
	    country_code: "MyString",
	    longitude: 1.5,
	    latitude: 1.5,
	    trend_id: 1)
	  end
	it "should return results from alchemy api" do
		expect(@tweet.get_sentiment).not_to be_nil 
    end
	it "should update tweet sentiment values" do
		@tweet.set_sentiment
		expect(@tweet.sentiment).not_to be_nil 
		expect(@tweet.sentiment_score).not_to be_nil 
    end
    it "should convert sentiment decimal to whole number" do
    	@tweet.update_attributes(sentiment_score: 1.0)
		expect(@tweet.get_highmap_val).to be_a(Fixnum)
    end
end


