require 'rails_helper'

RSpec.describe "workshop_participants/index", type: :view do
  before(:each) do
    assign(:workshop_participants, [
      WorkshopParticipant.create!(),
      WorkshopParticipant.create!()
    ])
  end

  it "renders a list of workshop_participants" do
    render
    cell_selector = 'div>p'
  end
end
