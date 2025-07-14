# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FeedbackEmailJob, type: :job do
  before do
    @facilitator_1 = FactoryBot.create(:facilitator)

    @registration_workshop_1 = FactoryBot.create(:future_registration_workshop)
    @application_workshop_1 = FactoryBot.create(:future_application_workshop)

    WorkshopFacilitator.create(
      facilitator_id: @facilitator_1.id,
      workshop_id: @registration_workshop_1.id
    )
    WorkshopFacilitator.create(
      facilitator_id: @facilitator_1.id,
      workshop_id: @application_workshop_1.id
    )
  end

  it 'enqueues an email to send feedback form when someone registers, sent when workshop ends' do
    visit "/workshops/#{@registration_workshop_1.id}"

    fill_in 'Name', with: 'Professor Test'
    fill_in 'Email', with: 'testing@example.com'

    click_on 'Submit Registration'

    expect(described_class).to have_enqueued_sidekiq_job(
      { participant_id: Participant.last.id, workshop_id: @registration_workshop_1.id }
    ).at(@registration_workshop_1.end_time)
  end

  it 'enqueues an email to send feedback form when someone who applied is accepted, sent when workshop ends' do
    visit "/workshops/#{@application_workshop_1.id}"

    fill_in 'Name', with: 'Professor Test'
    fill_in 'Email', with: 'testing@example.com'

    click_on 'Submit Application'

    login_as @facilitator_1

    visit "/workshops/#{@application_workshop_1.id}"

    click_button 'Accept participant application'

    expect(described_class).to have_enqueued_sidekiq_job(
      { participant_id: Participant.last.id, workshop_id: @application_workshop_1.id }
    ).at(@application_workshop_1.end_time)
  end

  it 'does not enqueue an email to send feedback form when participant is rejected' do
    visit "/workshops/#{@application_workshop_1.id}"

    fill_in 'Name', with: 'Professor Test'
    fill_in 'Email', with: 'testing@example.com'

    click_on 'Submit Application'

    login_as @facilitator_1

    visit "/workshops/#{@application_workshop_1.id}"

    click_button 'Reject participant application'

    expect(described_class).to_not have_enqueued_sidekiq_job(
      { participant_id: Participant.last.id, workshop_id: @application_workshop_1.id }
    ).at(@application_workshop_1.end_time)
  end

  it 'does not enqueue an email to send feedback form when participant is rejected' do
    visit "/workshops/#{@application_workshop_1.id}"

    fill_in 'Name', with: 'Professor Test'
    fill_in 'Email', with: 'testing@example.com'

    click_on 'Submit Application'

    login_as @facilitator_1

    visit "/workshops/#{@application_workshop_1.id}"

    click_button 'Waitlist participant application'

    expect(described_class).to_not have_enqueued_sidekiq_job(
      { participant_id: Participant.last.id, workshop_id: @application_workshop_1.id }
    ).at(@application_workshop_1.end_time)
  end
end
