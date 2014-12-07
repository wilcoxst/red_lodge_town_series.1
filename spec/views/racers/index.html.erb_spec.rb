require 'rails_helper'

RSpec.describe "racers/index", :type => :view do
  before(:each) do
    assign(:racers, [
      Racer.create!(
        :name => "Name",
        :gender => "Gender",
        :team => nil,
        :discipline => nil,
        :classification => nil
      ),
      Racer.create!(
        :name => "Name",
        :gender => "Gender",
        :team => nil,
        :discipline => nil,
        :classification => nil
      )
    ])
  end

  it "renders a list of racers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Gender".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
