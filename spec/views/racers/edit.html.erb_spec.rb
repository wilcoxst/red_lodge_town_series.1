require 'rails_helper'

RSpec.describe "racers/edit", :type => :view do
  before(:each) do
    @racer = assign(:racer, Racer.create!(
      :name => "MyString",
      :gender => "MyString",
      :team => nil,
      :discipline => nil,
      :classification => nil
    ))
  end

  it "renders the edit racer form" do
    render

    assert_select "form[action=?][method=?]", racer_path(@racer), "post" do

      assert_select "input#racer_name[name=?]", "racer[name]"

      assert_select "input#racer_gender[name=?]", "racer[gender]"

      assert_select "input#racer_team_id[name=?]", "racer[team_id]"

      assert_select "input#racer_discipline_id[name=?]", "racer[discipline_id]"

      assert_select "input#racer_classification_id[name=?]", "racer[classification_id]"
    end
  end
end
