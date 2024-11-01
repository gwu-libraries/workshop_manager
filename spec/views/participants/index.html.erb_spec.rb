require 'rails_helper'

RSpec.describe "participants/index", type: :view do
  before(:each) do
    assign(:participants, [
      Participant.create!(),
      Participant.create!()
    ])
  end

  it "renders a list of participants" do
    render
    cell_selector = 'div>p'
  end
end
