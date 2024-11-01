require 'rails_helper'

RSpec.describe 'workshop_participants/edit', type: :view do
  let(:workshop_1) { FactoryBot.create(:workshop) }

  let(:participant_1) { FactoryBot.create(:participant) }

  let(:workshop_participant) do
    WorkshopParticipant.create!(
      workshop_id: workshop_1.id,
      participant_id: participant_1.id
    )
  end

  before(:each) { assign(:workshop_participant, workshop_participant) }

  it 'renders the edit workshop_participant form' do
    render

    assert_select 'form[action=?][method=?]',
                  workshop_participant_path(workshop_participant),
                  'post' do
    end
  end
end
