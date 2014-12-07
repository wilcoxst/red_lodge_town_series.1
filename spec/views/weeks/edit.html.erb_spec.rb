require 'rails_helper'

RSpec.describe "weeks/edit", :type => :view do
  before(:each) do
    @week = assign(:week, Week.create!(
      :number => 1
    ))
  end

  it "renders the edit week form" do
    render

    assert_select "form[action=?][method=?]", week_path(@week), "post" do

      assert_select "input#week_number[name=?]", "week[number]"
    end
  end
end
