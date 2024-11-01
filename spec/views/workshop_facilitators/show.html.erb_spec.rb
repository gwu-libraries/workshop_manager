require 'rails_helper'

RSpec.describe 'workshop_facilitators/show', type: :view do
  let(:workshop_1) { FactoryBot.create(:workshop) }

  let(:facilitator_1) { FactoryBot.create(:facilitator) }

  before(:each) do
    assign(
      :workshop_facilitator,
      WorkshopFacilitator.create!(
        workshop_id: workshop_1.id,
        facilitator_id: facilitator_1.id
      )
    )
  end

  it 'renders attributes in <p>' do
    render
  end
end
