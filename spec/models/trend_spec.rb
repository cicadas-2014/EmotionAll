require 'rails_helper'
require 'spec_helper'

describe Trend do

  let(:trend) { create :trend }
  let(:get_twitter_client) { Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.consumer_key
      config.consumer_secret     = Rails.application.secrets.consumer_secret
      config.access_token        = Rails.application.secrets.oauth_token
      config.access_token_secret = Rails.application.secrets.oauth_token_secret
    end }
  let(:woeid) { 23424977 }

  describe "self#get_current_trends" do
    it "gets new trends from Twitter" do
      expect(Trend.get_current_trends).to_not change{trend.trends}.by(0)
    end
  end

  describe "#get_tweets" do
    it "gets tweets connected to a trend" do
      expect(trend.get_tweets).to_not change{trend.tweets}.by(0)
    end
  end

  describe "#create_tweets" do
    it "creates new tweet objects" do
      expect(trend.create_tweets).to_not change{Tweet.count}.by(0)
    end
  end

  describe "#update_tweet_sentiments" do
    expect(trend.update_tweet_sentiments).to
  end

  describe "self#most_recent_trends" do
    it "returns the most recent trends" do

    end
  end

  describe "self#update_tweets" do
    it "updates the tweets for the class" do

    end
  end

  describe "self#get_json_for_tweets" do
    it "correctly gets the json for tweets" do

    end
  end

  describe "self#get_random_trends" do
    it "" do
      pending
    end
  end

end
