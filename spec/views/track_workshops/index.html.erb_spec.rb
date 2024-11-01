require 'rails_helper'

RSpec.describe 'track_workshops/index', type: :view do
  let(:workshop_1) { FactoryBot.create(:workshop) }
  let(:workshop_2) { FactoryBot.create(:workshop) }

  let(:track_1) { FactoryBot.create(:track) }

  before(:each) do
    assign(
      :track_workshops,
      [
        TrackWorkshop.create!(track_id: track_1.id, workshop_id: workshop_1.id),
        TrackWorkshop.create!(track_id: track_1.id, workshop_id: workshop_2.id)
      ]
    )
  end

  it 'renders a list of track_workshops' do
    render
    cell_selector = 'div>p'
  end
end
