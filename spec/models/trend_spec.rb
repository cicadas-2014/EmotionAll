require 'rails_helper'
require 'spec_helper'

describe Trend do
  context "associations" do
    it { should have_many :tweets }
  end
end

describe "Trend model methods" do
    before(:each) do
         @trend= Trend.create(name: "MyTrend", woeid: 23424977, tweet_count: 0)
    end
    it "add ten trends to Trend table" do
      expect{Trend.current_trends}.to change{Trend.all.length}.by(10)
    end
    it "gets tweets connected to a trend" do
      expect(@trend.tweet_search).not_to be_nil
    end
  
  
  describe "get past trends" do
    before(:each) do
      15.times do
        Trend.create(name: "MyTrend", woeid: 23424977)
      end
       @response = Trend.old_trends
    end
    it "should create array" do
      expect(@response).to_not be_empty
    end
  end
end



