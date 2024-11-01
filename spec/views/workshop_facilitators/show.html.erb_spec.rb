require 'rails_helper'

RSpec.describe "workshop_facilitators/show", type: :view do
  before(:each) do
    assign(:workshop_facilitator, WorkshopFacilitator.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
