require 'rails_helper'

RSpec.describe 'track_workshops/edit', type: :view do
  let(:workshop_1) { FactoryBot.create(:workshop) }

  let(:track_1) { FactoryBot.create(:track) }

  let(:track_workshop) do
    TrackWorkshop.create!(workshop_id: workshop_1.id, track_id: track_1.id)
  end

  before(:each) { assign(:track_workshop, track_workshop) }

  it 'renders the edit track_workshop form' do
    render

    assert_select 'form[action=?][method=?]',
                  track_workshop_path(track_workshop),
                  'post' do
    end
  end
end
