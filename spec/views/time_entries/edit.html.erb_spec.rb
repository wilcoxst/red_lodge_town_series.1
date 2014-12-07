require 'rails_helper'

RSpec.describe "time_entries/edit", :type => :view do
  before(:each) do
    @time_entry = assign(:time_entry, TimeEntry.create!(
      :timing => "9.99",
      :run => 1,
      :week => nil,
      :racer => nil
    ))
  end

  it "renders the edit time_entry form" do
    render

    assert_select "form[action=?][method=?]", time_entry_path(@time_entry), "post" do

      assert_select "input#time_entry_timing[name=?]", "time_entry[timing]"

      assert_select "input#time_entry_run[name=?]", "time_entry[run]"

      assert_select "input#time_entry_week_id[name=?]", "time_entry[week_id]"

      assert_select "input#time_entry_racer_id[name=?]", "time_entry[racer_id]"
    end
  end
end
