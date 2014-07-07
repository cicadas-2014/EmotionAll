require 'rails_helper'
require 'spec_helper'

describe Trend do
  context "associations" do
    it { should have_many :tweets }
  end
end

describe "Trend model methods" do
    before(:each) do
         # @trend_tweets = Trend.tweets
         @trend= Trend.create(name: "MyTrend", woeid: 23424977)
    end
    # before(:each) do
    #      @trend= Trend.create(name: "MyTrend", woeid: 23424977)
    # end
    it "add ten trends to Trend table" do
      expect{Trend.get_current_trends}.to change{Trend.all.length}.by(10)
    end
    it "gets tweets connected to a trend" do
      expect(@trend.get_tweets).not_to be_nil 
    end
  describe "get json object for tweets" do
    before(:each) do
       @trend = Trend.create(name: "MyTrend", woeid: 23424977)
       @tweet = Tweet.create(country_code: "US", sentiment: "positive", sentiment_score: 0.5, trend_id: @trend.id)
       @response = Trend.get_json_for_tweets(@trend.id)
    end
    it "should create array" do
      expect(@response).to_not be_empty
    end
  end
  describe "get random trends" do
    before(:each) do
       @trend = Trend.create(name: "MyTrend", woeid: 23424977)
       @tweet = Tweet.create(country_code: "US", sentiment: "positive", sentiment_score: 0.5, trend_id: @trend.id)
       @response = Trend.get_random_trends
    end
    it "should create array" do
      expect(@response).to_not be_empty
    end
  end
  describe "get past trends" do
    before(:each) do
      15.times do
        Trend.create(name: "MyTrend", woeid: 23424977)
      end
       @response = Trend.get_past_trends
    end
    it "should create array" do
      # binding.pry
      expect(@response).to_not be_empty
    end
  end
end



