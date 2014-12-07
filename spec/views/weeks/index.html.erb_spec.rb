require 'rails_helper'

RSpec.describe "weeks/index", :type => :view do
  before(:each) do
    assign(:weeks, [
      Week.create!(
        :number => 1
      ),
      Week.create!(
        :number => 1
      )
    ])
  end

  it "renders a list of weeks" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
