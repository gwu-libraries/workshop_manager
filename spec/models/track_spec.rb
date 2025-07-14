# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Track, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many :track_workshops }
    it { is_expected.to have_many(:workshops).through(:track_workshops) }
  end
end
