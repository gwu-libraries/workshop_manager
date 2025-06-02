# frozen_string_literal: true

require 'rails_helper'

# test manually for now - functionality is working, tests are not, need to figure out a test setup.

RSpec.describe 'application status emails job', type: :job do
  before :each do
    @facilitator_1 = FactoryBot.create(:facilitator)
    @workshop_1 = FactoryBot.create(:future_application_workshop)
    @participant_1 =
      FactoryBot.create(:participant, workshop_id: @workshop_1.id)
    @participant_2 =
      FactoryBot.create(:participant, workshop_id: @workshop_1.id)
    @questions = [
      FactoryBot.create(:aq_short_answer_question, workshop_id: @workshop_1.id),
      FactoryBot.create(:aq_long_answer_question, workshop_id: @workshop_1.id),
      FactoryBot.create(:aq_likert_question, workshop_id: @workshop_1.id),
      FactoryBot.create(:aq_true_false_question, workshop_id: @workshop_1.id)
    ]

    WorkshopFacilitator.create(
      facilitator_id: @facilitator_1.id,
      workshop_id: @workshop_1.id
    )

    Participant.create(
      workshop_id: @workshop_1.id,
      application_status: 'pending'
    )
  end

  it 'enqueues an email if a participant is accepted' do
    login_as @facilitator_1

    visit "/workshops/#{@workshop_1.id}"

    click_button 'Accept participant application'

    expect(ApplicationAcceptedEmailJob).to have_enqueued_sidekiq_job(
      { participant_id: @participant_1.id, workshop_id: @workshop_1.id }
    )
  end

  it 'enqueues an email if a participant is waitlisted' do
    login_as @facilitator_1

    visit "/workshops/#{@workshop_1.id}"

    click_button 'Reject participant application'

    expect(ApplicationWaitlistedEmailJob).to have_enqueued_sidekiq_job(
      { participant_id: @participant_1.id, workshop_id: @workshop_1.id }
    )
  end

  it 'enqueues an email if a participant is rejected' do
    login_as @facilitator_1

    visit "/workshops/#{@workshop_1.id}"

    click_button 'Waitlist participant application'

    expect(ApplicationRejectedEmailJob).to have_enqueued_sidekiq_job(
      { participant_id: @participant_1.id, workshop_id: @workshop_1.id }
    )
  end
end
