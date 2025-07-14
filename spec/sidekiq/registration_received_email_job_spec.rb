# frozen_string_literal: true

require 'rails_helper'
RSpec.describe RegistrationReceivedEmailJob, type: :job do
  it 'enqueues an email confirming registration when a participant registers' do
    facilitator_1 = FactoryBot.create(:facilitator)
    workshop_1 = FactoryBot.create(:future_registration_workshop)

    WorkshopFacilitator.create(
      facilitator_id: facilitator_1.id,
      workshop_id: workshop_1.id
    )

    visit "/workshops/#{workshop_1.id}"

    fill_in 'Name', with: 'Professor Test'
    fill_in 'Email', with: 'testing@example.com'

    click_on 'Submit Registration'

    expect(described_class).to have_enqueued_sidekiq_job(
      { participant_id: Participant.last.id, workshop_id: workshop_1.id }
    )
  end
end
