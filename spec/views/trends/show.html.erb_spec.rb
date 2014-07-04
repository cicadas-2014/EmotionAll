require 'rails_helper'

RSpec.describe "trends/show", :type => :view do
  before(:each) do
    @trend = assign(:trend, Trend.create!(
      :trend => "Trend",
      :woeid => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Trend/)
    expect(rendered).to match(/1/)
  end
end
