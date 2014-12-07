require 'rails_helper'

RSpec.describe "weeks/new", :type => :view do
  before(:each) do
    assign(:week, Week.new(
      :number => 1
    ))
  end

  it "renders new week form" do
    render

    assert_select "form[action=?][method=?]", weeks_path, "post" do

      assert_select "input#week_number[name=?]", "week[number]"
    end
  end
end
