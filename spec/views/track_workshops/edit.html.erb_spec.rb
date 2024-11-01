require 'rails_helper'

RSpec.describe "track_workshops/edit", type: :view do
  let(:track_workshop) {
    TrackWorkshop.create!()
  }

  before(:each) do
    assign(:track_workshop, track_workshop)
  end

  it "renders the edit track_workshop form" do
    render

    assert_select "form[action=?][method=?]", track_workshop_path(track_workshop), "post" do
    end
  end
end
