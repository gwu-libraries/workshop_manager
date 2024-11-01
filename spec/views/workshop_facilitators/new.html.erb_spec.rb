require 'rails_helper'

RSpec.describe "workshop_facilitators/new", type: :view do
  before(:each) do
    assign(:workshop_facilitator, WorkshopFacilitator.new())
  end

  it "renders new workshop_facilitator form" do
    render

    assert_select "form[action=?][method=?]", workshop_facilitators_path, "post" do
    end
  end
end
