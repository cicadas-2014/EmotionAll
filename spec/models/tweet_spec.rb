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
                        	     language: "MyString",
                        	     country_code: "MyString",
                        	     longitude: 1.5,
                        	     latitude: 1.5,
                          	   trend_id: 1)
	  end
	# it "should return results from alchemy api" do
	# 	expect(@tweet.analyze_sentiment).not_to be_nil
 #    end
	# it "should update tweet sentiment values" do
	# 	@tweet.analyze_sentiment
	# 	expect(@tweet.sentiment).not_to be_nil
	# 	expect(@tweet.sentiment_score).not_to be_nil
 #  end
end


