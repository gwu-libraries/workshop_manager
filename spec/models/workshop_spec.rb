# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Workshop, type: :model do
  describe 'relationships' do
    it { should have_many :track_workshops }
    it { should have_many(:tracks).through(:track_workshops) }

    it { should have_many :workshop_facilitators }
    it { should have_many(:facilitators).through(:workshop_facilitators) }

    it { should have_many(:participants) }

    it { should have_many :application_questions }
    it do
      should have_many(:application_question_responses).through(
               :application_questions
             )
    end

    it { should have_many :feedback_questions }
    it do
      should have_many(:feedback_question_responses).through(
               :feedback_questions
             )
    end
  end

  describe 'model methods' do
    it '.registration_required returns all workshops with registration required' do
      5.times do
        FactoryBot.create(
          :future_workshop,
          registration_modality: 'registration_required'
        )
      end

      3.times do
        FactoryBot.create(
          :future_workshop,
          registration_modality: 'no_registration_required'
        )
      end

      1.times do
        FactoryBot.create(
          :future_workshop,
          registration_modality: 'application_required'
        )
      end

      expect(Workshop.registration_required.count).to eq(5)
    end

    it '.no_registration_required returns all workshops with no registration required' do
      5.times do
        FactoryBot.create(
          :future_workshop,
          registration_modality: 'registration_required'
        )
      end

      3.times do
        FactoryBot.create(
          :future_workshop,
          registration_modality: 'no_registration_required'
        )
      end

      1.times do
        FactoryBot.create(
          :future_workshop,
          registration_modality: 'application_required'
        )
      end

      expect(Workshop.no_registration_required.count).to eq(3)
    end

    it '.application_required returns all workshops with no registration required' do
      5.times do
        FactoryBot.create(
          :future_workshop,
          registration_modality: 'registration_required'
        )
      end

      3.times do
        FactoryBot.create(
          :future_workshop,
          registration_modality: 'no_registration_required'
        )
      end

      1.times do
        FactoryBot.create(
          :future_workshop,
          registration_modality: 'application_required'
        )
      end

      expect(Workshop.application_required.count).to eq(1)
    end
  end

  describe 'instance methods' do
    it '.registration_required returns true if registration is required' do
      workshop_1 =
        FactoryBot.create(
          :future_workshop,
          registration_modality: 'registration_required'
        )

      expect(workshop_1.registration_required).to eq(true)
    end

    it '.registration_required returns false if registration required not selected' do
      workshop_1 =
        FactoryBot.create(
          :future_workshop,
          registration_modality: 'application_required'
        )

      expect(workshop_1.registration_required).to eq(false)
    end

    it '.application_required returns true if application is required' do
      workshop_1 =
        FactoryBot.create(
          :future_workshop,
          registration_modality: 'application_required'
        )

      expect(workshop_1.application_required).to eq(true)
    end

    it '.application_required returns false if application required not selected' do
      workshop_1 =
        FactoryBot.create(
          :future_workshop,
          registration_modality: 'registration_required'
        )

      expect(workshop_1.application_required).to eq(false)
    end

    it '.no_registration_required returns true if no registration is required' do
      workshop_1 =
        FactoryBot.create(
          :future_workshop,
          registration_modality: 'no_registration_required'
        )

      expect(workshop_1.no_registration_required).to eq(true)
    end

    it '.application_required returns false if application required not selected' do
      workshop_1 =
        FactoryBot.create(
          :future_workshop,
          registration_modality: 'registration_required'
        )

      expect(workshop_1.no_registration_required).to eq(false)
    end

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
