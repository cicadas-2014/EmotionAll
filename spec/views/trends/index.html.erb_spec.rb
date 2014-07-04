require 'rails_helper'

RSpec.describe "trends/index", :type => :view do
  before(:each) do
    assign(:trends, [
      Trend.create!(
        :trend => "Trend",
        :woeid => 1
      ),
      Trend.create!(
        :trend => "Trend",
        :woeid => 1
      )
    ])
  end

  it "renders a list of trends" do
    render
    assert_select "tr>td", :text => "Trend".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
