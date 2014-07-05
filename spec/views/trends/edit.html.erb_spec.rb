require 'rails_helper'

RSpec.describe "trends/edit", :type => :view do
  before(:each) do
    @trend = assign(:trend, Trend.create!(
      :trend => "MyString",
      :woeid => 1
    ))
  end

  it "renders the edit trend form" do
    render

    assert_select "form[action=?][method=?]", trend_path(@trend), "post" do

      assert_select "input#trend_trend[name=?]", "trend[trend]"

      assert_select "input#trend_woeid[name=?]", "trend[woeid]"
    end
  end
end
