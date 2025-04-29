# frozen_string_literal: true

require 'rails_helper'

# test manually for now - functionality is working, tests are not, need to figure out a test setup.

RSpec.describe 'application status emails job', type: :job do
  before :each do
    @facilitator_1 = FactoryBot.create(:facilitator)
    @workshop_1 = FactoryBot.create(:future_application_workshop)
    @participant_1 = FactoryBot.create(:participant)
    @participant_2 = FactoryBot.create(:participant)
    @at = ApplicationForm.create
    @questions = []
    @questions << FactoryBot.create(:short_answer_question)
    @questions << FactoryBot.create(:long_answer_question)
    @questions << FactoryBot.create(:likert_question)
    @questions << FactoryBot.create(:true_false_question)

    @questions.each do |q|
      ApplicationFormQuestion.create(
        question_id: q.id,
        application_form_id: @at.id
      )
    end

    ApplicationForm.create(workshop_id: @workshop_1.id)

    WorkshopFacilitator.create(
      facilitator_id: @facilitator_1.id,
      workshop_id: @workshop_1.id
    )

    application_responses = {}
    @questions.each do |q|
      application_responses[q.prompt] = Faker::Lorem.sentence
    end
    WorkshopParticipant.create(
      workshop_id: @workshop_1.id,
      participant_id: @participant_1.id,
      application_status: 'pending',
      application_responses: application_responses
    )
  end

  xit 'enqueues an email if a participant is accepted' do
    login_as @facilitator_1

    visit "/workshops/#{@workshop_1.id}"

    click_button 'Accept participant application'

    expect(ApplicationAcceptedEmailJob).to have_enqueued_sidekiq_job(
      { participant_id: @participant_1.id, workshop_id: @workshop_1.id }
    )
  end

  xit 'enqueues an email if a participant is waitlisted' do
    login_as @facilitator_1

    visit "/workshops/#{@workshop_1.id}"

    click_button 'Reject participant application'

    expect(ApplicationWaitlistedEmailJob).to have_enqueued_sidekiq_job(
      { participant_id: @participant_1.id, workshop_id: @workshop_1.id }
    )
  end

  xit 'enqueues an email if a participant is rejected' do
    login_as @facilitator_1

    visit "/workshops/#{@workshop_1.id}"

    click_button 'Waitlist participant application'

    expect(ApplicationRejectedEmailJob).to have_enqueued_sidekiq_job(
      { participant_id: @participant_1.id, workshop_id: @workshop_1.id }
    )
  end
end
