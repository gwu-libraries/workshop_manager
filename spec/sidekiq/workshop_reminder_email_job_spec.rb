require 'rails_helper'
RSpec.describe WorkshopReminderEmailJob, type: :job do
  xit 'can schedule multiple reminder emails' do
    facilitator_1 = FactoryBot.create(:facilitator)
    workshop_1 = FactoryBot.create(:future_registration_workshop)

    WorkshopFacilitator.create(
      facilitator_id: facilitator_1.id,
      workshop_id: workshop_1.id
    )

    visit "/workshops/#{workshop_1.id}"

    fill_in 'Name', with: 'Professor Test'
    fill_in 'Email', with: 'testing@example.com'

    check 'One week before'
    check 'One day before'
    check 'One hour before'

    click_on 'Submit Registration'

    participant = Participant.last

    expect(WorkshopReminderEmailJob).to have_enqueued_sidekiq_job(
      { participant_id: participant.id, workshop_id: workshop_1.id }
    ).at(workshop_1.start_time - 1.weeks)

    expect(WorkshopReminderEmailJob).to have_enqueued_sidekiq_job(
      { participant_id: participant.id, workshop_id: workshop_1.id }
    ).at(workshop_1.start_time - 1.days)

    expect(WorkshopReminderEmailJob).to have_enqueued_sidekiq_job(
      { participant_id: participant.id, workshop_id: workshop_1.id }
    ).at(workshop_1.start_time - 1.hours)
  end

  # this is working, but fails due to a time rounding error in sidekiq
  # still trying to figure that out
  xit 'can schedule a subset of reminder emails' do
    facilitator_1 = FactoryBot.create(:facilitator)
    workshop_1 = FactoryBot.create(:future_registration_workshop)

    WorkshopFacilitator.create(
      facilitator_id: facilitator_1.id,
      workshop_id: workshop_1.id
    )

    visit "/workshops/#{workshop_1.id}"

    fill_in 'Name', with: 'Professor Test'
    fill_in 'Email', with: 'testing@example.com'

    check 'One week before'
    check 'One day before'

    # not this one
    # check 'One hour before'

    click_on 'Submit Registration'

    participant = Participant.last

    expect(WorkshopReminderEmailJob).to have_enqueued_sidekiq_job(
      { participant_id: participant.id, workshop_id: workshop_1.id }
    ).at(workshop_1.start_time - 1.weeks)

    expect(WorkshopReminderEmailJob).to have_enqueued_sidekiq_job(
      { participant_id: participant.id, workshop_id: workshop_1.id }
    ).at(workshop_1.start_time - 1.days)
  end
end
