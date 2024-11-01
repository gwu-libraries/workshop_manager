require 'rails_helper'

RSpec.describe WorkshopParticipant, type: :model do
  describe 'relationships' do
    it { should belong_to :workshop }
    it { should belong_to :participant }
  end
end
