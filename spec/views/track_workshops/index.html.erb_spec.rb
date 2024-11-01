require 'rails_helper'

RSpec.describe "track_workshops/index", type: :view do
  before(:each) do
    assign(:track_workshops, [
      TrackWorkshop.create!(),
      TrackWorkshop.create!()
    ])
  end

  it "renders a list of track_workshops" do
    render
    cell_selector = 'div>p'
  end
end
