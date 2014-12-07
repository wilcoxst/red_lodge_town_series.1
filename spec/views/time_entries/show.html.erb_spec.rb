require 'rails_helper'

RSpec.describe "time_entries/show", :type => :view do
  before(:each) do
    @time_entry = assign(:time_entry, TimeEntry.create!(
      :timing => "9.99",
      :run => 1,
      :week => nil,
      :racer => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
