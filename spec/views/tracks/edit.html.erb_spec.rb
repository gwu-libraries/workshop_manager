require 'rails_helper'

RSpec.describe "tracks/edit", type: :view do
  let(:track) {
    Track.create!()
  }

  before(:each) do
    assign(:track, track)
  end

  it "renders the edit track form" do
    render

    assert_select "form[action=?][method=?]", track_path(track), "post" do
    end
  end
end
