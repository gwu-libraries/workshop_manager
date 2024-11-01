require 'rails_helper'

RSpec.describe "workshop_facilitators/edit", type: :view do
  let(:workshop_facilitator) {
    WorkshopFacilitator.create!()
  }

  before(:each) do
    assign(:workshop_facilitator, workshop_facilitator)
  end

  it "renders the edit workshop_facilitator form" do
    render

    assert_select "form[action=?][method=?]", workshop_facilitator_path(workshop_facilitator), "post" do
    end
  end
end
