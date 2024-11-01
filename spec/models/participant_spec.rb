require 'rails_helper'

RSpec.describe Participant, type: :model do
  describe 'relationships' do
    it { should have_many :workshop_participants }
    it { should have_many(:workshops).through(:workshop_participants) }
  end
end
