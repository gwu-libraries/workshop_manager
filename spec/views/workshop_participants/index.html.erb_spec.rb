require 'rails_helper'

RSpec.describe 'workshop_participants/index', type: :view do
  let(:workshop_1) { FactoryBot.create(:workshop) }
  let(:workshop_2) { FactoryBot.create(:workshop) }

  let(:participant_1) { FactoryBot.create(:participant) }

  before(:each) do
    assign(
      :workshop_participants,
      [
        WorkshopParticipant.create!(
          workshop_id: workshop_1.id,
          participant_id: participant_1.id
        ),
        WorkshopParticipant.create!(
          workshop_id: workshop_2.id,
          participant_id: participant_1.id
        )
      ]
    )
  end

  it 'renders a list of workshop_participants' do
    render
    cell_selector = 'div>p'
  end
end
