# frozen_string_literal: true

require 'rails_helper'
RSpec.describe ApplicationReceivedEmailJob, type: :job do
  it 'enqueues an email confirming application recieved when a participant applies to a workshop' do
    facilitator_1 = FactoryBot.create(:facilitator)
    workshop_1 = FactoryBot.create(:future_application_workshop)
    FactoryBot.create(:aq_short_answer_question, workshop_id: workshop_1.id)
    FactoryBot.create(:aq_long_answer_question, workshop_id: workshop_1.id)
    FactoryBot.create(:aq_likert_question, workshop_id: workshop_1.id)
    FactoryBot.create(:aq_true_false_question, workshop_id: workshop_1.id)

    WorkshopFacilitator.create(
      facilitator_id: facilitator_1.id,
      workshop_id: workshop_1.id
    )

    visit "/workshops/#{workshop_1.id}"

    fill_in 'application_form_name', with: 'Professor Test'
    fill_in 'application_form_email', with: 'testing@example.com'

    click_on 'Submit Application'

    expect(described_class).to have_enqueued_sidekiq_job(
      { participant_id: Participant.last.id, workshop_id: workshop_1.id }
    )
  end
end
