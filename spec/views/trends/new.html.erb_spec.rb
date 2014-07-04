require 'rails_helper'

RSpec.describe "trends/new", :type => :view do
  before(:each) do
    assign(:trend, Trend.new(
      :trend => "MyString",
      :woeid => 1
    ))
  end

  it "renders new trend form" do
    render

    assert_select "form[action=?][method=?]", trends_path, "post" do

      assert_select "input#trend_trend[name=?]", "trend[trend]"

      assert_select "input#trend_woeid[name=?]", "trend[woeid]"
    end
  end
end
