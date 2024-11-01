require 'rails_helper'

RSpec.describe "workshop_facilitators/index", type: :view do
  before(:each) do
    assign(:workshop_facilitators, [
      WorkshopFacilitator.create!(),
      WorkshopFacilitator.create!()
    ])
  end

  it "renders a list of workshop_facilitators" do
    render
    cell_selector = 'div>p'
  end
end
