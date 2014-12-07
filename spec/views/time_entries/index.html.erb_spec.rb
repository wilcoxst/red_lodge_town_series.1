require 'rails_helper'

RSpec.describe "time_entries/index", :type => :view do
  before(:each) do
    assign(:time_entries, [
      TimeEntry.create!(
        :timing => "9.99",
        :run => 1,
        :week => nil,
        :racer => nil
      ),
      TimeEntry.create!(
        :timing => "9.99",
        :run => 1,
        :week => nil,
        :racer => nil
      )
    ])
  end

  it "renders a list of time_entries" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
