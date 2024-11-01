require 'rails_helper'

RSpec.describe 'workshop_participants/show', type: :view do
  let(:workshop_1) { FactoryBot.create(:workshop) }

  let(:participant_1) { FactoryBot.create(:participant) }

  before(:each) do
    assign(
      :workshop_participant,
      WorkshopParticipant.create!(
        workshop_id: workshop_1.id,
        participant_id: participant_1.id
      )
    )
  end

  it 'renders attributes in <p>' do
    render
  end
end
