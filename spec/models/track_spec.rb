require 'rails_helper'

RSpec.describe Track, type: :model do
  describe 'relationships' do
    it { should have_many :track_workshops }
    it { should have_many(:workshops).through(:track_workshops) }
  end
end
