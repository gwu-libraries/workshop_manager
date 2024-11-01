require 'rails_helper'

RSpec.describe "track_workshops/show", type: :view do
  before(:each) do
    assign(:track_workshop, TrackWorkshop.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
