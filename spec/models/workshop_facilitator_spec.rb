# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkshopFacilitator, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to :workshop }
    it { is_expected.to belong_to :facilitator }
  end
end
