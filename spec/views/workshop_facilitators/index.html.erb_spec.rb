require 'rails_helper'

RSpec.describe 'workshop_facilitators/index', type: :view do
  let(:workshop_1) { FactoryBot.create(:workshop) }
  let(:workshop_2) { FactoryBot.create(:workshop) }

  let(:facilitator_1) { FactoryBot.create(:facilitator) }

  before(:each) do
    assign(
      :workshop_facilitators,
      [
        WorkshopFacilitator.create!(
          workshop_id: workshop_1.id,
          facilitator_id: facilitator_1.id
        ),
        WorkshopFacilitator.create!(
          workshop_id: workshop_2.id,
          facilitator_id: facilitator_1.id
        )
      ]
    )
  end

  it 'renders a list of workshop_facilitators' do
    render
    cell_selector = 'div>p'
  end
end
