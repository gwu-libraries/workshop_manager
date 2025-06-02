# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Workshop, type: :model do
  describe 'relationships' do
    it { should have_many :track_workshops }
    it { should have_many(:tracks).through(:track_workshops) }

    it { should have_many :workshop_facilitators }
    it { should have_many(:facilitators).through(:workshop_facilitators) }

    it { should have_many(:participants) }
  end

  describe 'methods' do
    it 'can return a total attendance count with an individual attendance modality' do
      workshop_1 =
        FactoryBot.create(:future_workshop, attendance_modality: 'individual')

      # two attending
      2.times do
        FactoryBot.create(
          :participant,
          workshop_id: workshop_1.id,
          in_attendance: true
        )
      end

      # one not attending
      FactoryBot.create(
        :participant,
        workshop_id: workshop_1.id,
        in_attendance: false
      )

      expect(workshop_1.total_attendance).to eq(2)
    end

    it 'can return a total attendance count with a collective attendance modality' do
      workshop_1 =
        FactoryBot.create(
          :future_workshop,
          attendance_modality: 'collective',
          virtual_attendance_count: 6,
          in_person_attendance_count: 3
        )

      expect(workshop_1.total_attendance).to eq(9)
    end
  end
end
