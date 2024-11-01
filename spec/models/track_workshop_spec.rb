require 'rails_helper'

RSpec.describe TrackWorkshop, type: :model do
  describe 'relationships' do
    it { should belong_to :track }
    it { should belong_to :workshop }
  end
end
