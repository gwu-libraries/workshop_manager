require 'rails_helper'

RSpec.describe Workshop, type: :model do
  describe 'relationships' do
    it { should have_many :track_workshops }
    it { should have_many(:tracks).through(:track_workshops) }

    it { should have_many :workshop_facilitators }
    it { should have_many(:facilitators).through(:workshop_facilitators) }

    it { should have_many :workshop_participants }
    it { should have_many(:participants).through(:workshop_participants) }
  end
end
