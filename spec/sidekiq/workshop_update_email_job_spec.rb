require 'rails_helper'
RSpec.describe WorkshopUpdateEmailJob, type: :job do
  it 'enqueues update emails for all participants of a workshop when it is updated' do
    facilitator_1 = FactoryBot.create(:facilitator)
    workshop_1 = FactoryBot.create(:future_registration_workshop)

    WorkshopFacilitator.create(
      workshop_id: workshop_1.id,
      facilitator_id: facilitator_1.id
    )

    workshop_participants = []

    5.times { workshop_participants << FactoryBot.create(:participant) }

    workshop_participants.map do |p|
      WorkshopParticipant.create(
        workshop_id: workshop_1.id,
        participant_id: p.id
      )
    end

    non_participant = FactoryBot.create(:participant)

    login_as facilitator_1

    visit "/workshops/#{workshop_1.id}/edit"

    fill_in 'Title', with: 'An updated title'

    click_on 'Edit Workshop'

    workshop_participants.each do |p|
      expect(WorkshopUpdateEmailJob).to have_enqueued_sidekiq_job(
        { participant_id: p.id, workshop_id: workshop_1.id }
      )
    end
  end
end
