# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'workshops/show', type: :view do
  before do
    @admin = FactoryBot.create(:admin)

    @proposal_pending_workshop =
      FactoryBot.create(
        :proposal_pending_workshop,
        start_time: DateTime.now + 1.hour,
        end_time: DateTime.now + 2.hours
      )

    @future_application_workshop =
      FactoryBot.create(
        :future_application_workshop,
        start_time: DateTime.now + 1.hour,
        end_time: DateTime.now + 2.hours
      )

    @past_application_workshop =
      FactoryBot.create(
        :past_application_workshop,
        start_time: DateTime.now - 2.hours,
        end_time: DateTime.now - 1.hour
      )

    @future_registration_workshop =
      FactoryBot.create(
        :future_registration_workshop,
        start_time: DateTime.now + 4.hours,
        end_time: DateTime.now + 5.hours
      )

    @past_registration_workshop =
      FactoryBot.create(
        :past_registration_workshop,
        start_time: DateTime.now - 6.hours,
        end_time: DateTime.now - 5.hours
      )

    @facilitator_1 = FactoryBot.create(:facilitator)
    @facilitator_2 = FactoryBot.create(:facilitator)

    Workshop.all.find_each do |workshop|
      WorkshopFacilitator.create(
        workshop_id: workshop.id,
        facilitator_id: @facilitator_1.id
      )

      FactoryBot.create(:aq_true_false_question, workshop_id: workshop.id)
      FactoryBot.create(:aq_short_answer_question, workshop_id: workshop.id)
      FactoryBot.create(:aq_long_answer_question, workshop_id: workshop.id)
      FactoryBot.create(:aq_likert_question, workshop_id: workshop.id)
    end
  end

  it 'displays an application form if in future and application required' do
    visit workshop_path(@future_application_workshop)

    @future_application_workshop.application_questions.each do |question|
      expect(page).to have_content(question.prompt.humanize)
    end
  end

  it 'does not display an application if workshop is in the past and application required' do
    visit workshop_path(@past_application_workshop)

    @past_application_workshop.application_questions.each do |question|
      expect(page).not_to have_content(question.prompt.humanize)
    end
  end

  it 'displays a registration form if workshop is in the future and registration required' do
    visit workshop_path(@future_registration_workshop)

    expect(page).to have_content(
      "Register for #{@future_registration_workshop.title}"
    )

    within '.registration_form' do
      expect(page).to have_content('Name')
      expect(page).to have_content('Email')
    end
  end

  it 'does not display a registration form if workshop is in the past and registration required' do
    visit workshop_path(@past_registration_workshop)

    expect(page).not_to have_content(
      "Register for #{@past_registration_workshop.title}"
    )
    expect(page).not_to have_content(
      "Apply for #{@past_registration_workshop.title}"
    )
  end

  it 'displays a button to approve a pending workshop if logged in as an admin and workshop is pending' do
    login_as @admin

    visit workshop_path(@proposal_pending_workshop)

    click_button 'Approve this workshop'

    visit workshops_path

    expect(page).to have_content(@proposal_pending_workshop.title)
  end

  it 'displays a button to reject a pending workshop if logged in as an admin and workshop is pending' do
    login_as @admin

    visit workshop_path(@proposal_pending_workshop)

    click_button 'Reject this workshop'

    visit workshops_path

    expect(page).not_to have_content(@proposal_pending_workshop.title)
  end

  it 'does not display a button to approve or reject a workshop if facilitator is not admin' do
    login_as @facilitator

    visit workshop_path(@proposal_pending_workshop)

    expect(page).not_to have_content('approve or reject?')
  end

  it 'links to a facilitator profile when clicking a facilitator name' do
    visit workshop_path(@future_registration_workshop)

    expect(page).to have_link(
      @facilitator_1.name,
      href: @facilitator_1.profile_url
    )
  end
end
