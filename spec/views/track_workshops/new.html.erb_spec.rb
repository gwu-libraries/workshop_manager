require 'rails_helper'

RSpec.describe "track_workshops/new", type: :view do
  before(:each) do
    assign(:track_workshop, TrackWorkshop.new())
  end

  it "renders new track_workshop form" do
    render

    assert_select "form[action=?][method=?]", track_workshops_path, "post" do
    end
  end
end
