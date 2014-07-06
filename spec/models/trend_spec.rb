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
      expect(get_twitter_client.trends(woeid))
    end
  end

end
