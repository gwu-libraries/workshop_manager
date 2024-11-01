require 'rails_helper'

RSpec.describe 'track_workshops/show', type: :view do
  let(:workshop_1) { FactoryBot.create(:workshop) }

  let(:track_1) { FactoryBot.create(:track) }

  before(:each) do
    assign(
      :track_workshop,
      TrackWorkshop.create!(track_id: track_1.id, workshop_id: workshop_1.id)
    )
  end

  it 'renders attributes in <p>' do
    render
  end
end
