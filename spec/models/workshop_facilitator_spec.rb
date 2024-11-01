require 'rails_helper'

RSpec.describe WorkshopFacilitator, type: :model do
  describe 'relationships' do
    it { should belong_to :workshop }
    it { should belong_to :facilitator }
  end
end
