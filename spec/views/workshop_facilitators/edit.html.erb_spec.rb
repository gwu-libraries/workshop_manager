require 'rails_helper'

RSpec.describe 'workshop_facilitators/edit', type: :view do
  let(:workshop_1) { FactoryBot.create(:workshop) }

  let(:facilitator_1) { FactoryBot.create(:facilitator) }

  let(:workshop_facilitator) do
    WorkshopFacilitator.create!(
      workshop_id: workshop_1.id,
      facilitator_id: facilitator_1.id
    )
  end

  before(:each) { assign(:workshop_facilitator, workshop_facilitator) }

  it 'renders the edit workshop_facilitator form' do
    render

    assert_select 'form[action=?][method=?]',
                  workshop_facilitator_path(workshop_facilitator),
                  'post' do
    end
  end
end
