require 'rails_helper'
RSpec.describe WorkshopRegistrationEmailJob, type: :job do
  it 'enqueues an email confirming registration when a participant registers' do
    facilitator_1 = FactoryBot.create(:facilitator)
    workshop_1 =
      FactoryBot.create(
        :future_workshop,
        registration_modality: 'registration_required'
      )

    WorkshopFacilitator.create(
      facilitator_id: facilitator_1.id,
      workshop_id: workshop_1.id
    )

    visit "/workshops/#{workshop_1.id}"

    fill_in 'Name', with: 'Professor Test'
    fill_in 'Email', with: 'testing@example.com'

    click_on 'Submit Registration'

    participant = Participant.last

    expect(WorkshopRegistrationEmailJob).to have_enqueued_sidekiq_job(
      { participant_id: participant.id, workshop_id: workshop_1.id }
    )
  end
end
