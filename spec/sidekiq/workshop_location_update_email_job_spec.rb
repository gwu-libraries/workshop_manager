# frozen_string_literal: true

require 'rails_helper'
RSpec.describe WorkshopLocationUpdateEmailJob, type: :job do
  before(:each) do
    @facilitator_1 = FactoryBot.create(:facilitator)
    @workshop_1 = FactoryBot.create(:future_registration_workshop)

    WorkshopFacilitator.create(
      workshop_id: @workshop_1.id,
      facilitator_id: @facilitator_1.id
    )

    @workshop_participants = []

    5.times { @workshop_participants << FactoryBot.create(:participant) }

    @workshop_participants.map do |p|
      WorkshopParticipant.create(
        workshop_id: @workshop_1.id,
        participant_id: p.id
      )
    end

    login_as @facilitator_1

    visit "/workshops/#{@workshop_1.id}/edit"
  end

  it 'enqueues update emails for all participants of a workshop when the in-person location is changed' do
    fill_in 'workshop_in_person_location', with: 'A new location'

    click_on 'Save Changes'

    @workshop_participants.each do |p|
      expect(WorkshopLocationUpdateEmailJob).to have_enqueued_sidekiq_job(
        { participant_id: p.id, workshop_id: @workshop_1.id }
      )
    end
  end

  it 'enqueues update emails for all participants of a workshop when the virtual location is changed' do
    fill_in 'workshop_virtual_location', with: 'A new location'

    click_on 'Save Changes'

    @workshop_participants.each do |p|
      expect(WorkshopLocationUpdateEmailJob).to have_enqueued_sidekiq_job(
        { participant_id: p.id, workshop_id: @workshop_1.id }
      )
    end
  end

  it 'does not enqueue update emails for all participants of a workshop when the start time is changed' do
    select '01', from: 'workshop_start_time_5i'

    click_on 'Save Changes'

    @workshop_participants.each do |p|
      expect(WorkshopLocationUpdateEmailJob).to_not have_enqueued_sidekiq_job(
        { participant_id: p.id, workshop_id: @workshop_1.id }
      )
    end
  end

  it 'does not enqueue update emails for all participants of a workshop when the end time is changed' do
    select '01', from: 'workshop_end_time_5i'

    click_on 'Save Changes'

    @workshop_participants.each do |p|
      expect(WorkshopLocationUpdateEmailJob).to_not have_enqueued_sidekiq_job(
        { participant_id: p.id, workshop_id: @workshop_1.id }
      )
    end
  end
end
