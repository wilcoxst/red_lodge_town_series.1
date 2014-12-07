require 'rails_helper'

RSpec.describe "weeks/show", :type => :view do
  before(:each) do
    @week = assign(:week, Week.create!(
      :number => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
  end
end
