require 'rails_helper'

RSpec.describe "racers/new", :type => :view do
  before(:each) do
    assign(:racer, Racer.new(
      :name => "MyString",
      :gender => "MyString",
      :team => nil,
      :discipline => nil,
      :classification => nil
    ))
  end

  it "renders new racer form" do
    render

    assert_select "form[action=?][method=?]", racers_path, "post" do

      assert_select "input#racer_name[name=?]", "racer[name]"

      assert_select "input#racer_gender[name=?]", "racer[gender]"

      assert_select "input#racer_team_id[name=?]", "racer[team_id]"

      assert_select "input#racer_discipline_id[name=?]", "racer[discipline_id]"

      assert_select "input#racer_classification_id[name=?]", "racer[classification_id]"
    end
  end
end
