require 'rails_helper'
RSpec.describe WorkshopApplicationReceivedEmailJob, type: :job do
  it 'enqueues an email confirming application recieved when a participant applies to a workshop' do
    facilitator_1 = FactoryBot.create(:facilitator)
    workshop_1 = FactoryBot.create(:future_application_workshop)
    at = ApplicationTemplate.create
    questions = []
    questions << FactoryBot.create(:short_answer_question)
    questions << FactoryBot.create(:long_answer_question)
    questions << FactoryBot.create(:likert_question)
    questions << FactoryBot.create(:true_false_question)

    questions.each do |q|
      ApplicationTemplateQuestion.create(
        question_id: q.id,
        application_template_id: at.id
      )
    end

    wat =
      WorkshopApplicationTemplate.create(
        application_template_id: at.id,
        workshop_id: workshop_1.id
      )

    WorkshopFacilitator.create(
      facilitator_id: facilitator_1.id,
      workshop_id: workshop_1.id
    )

    visit "/workshops/#{workshop_1.id}"

    fill_in 'Name', with: 'Professor Test'
    fill_in 'Email', with: 'testing@example.com'

    click_on 'Submit Application'

    participant = Participant.last

    expect(WorkshopApplicationReceivedEmailJob).to have_enqueued_sidekiq_job(
      { participant_id: participant.id, workshop_id: workshop_1.id }
    )
  end
end
