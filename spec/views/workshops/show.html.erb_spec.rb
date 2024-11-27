require 'rails_helper'

RSpec.describe 'workshops/show', type: :view do
  before(:each) do
    @admin = FactoryBot.create(:admin)

    @proposal_pending_workshop = FactoryBot.create(:proposal_pending_workshop)

    @future_application_workshop =
      FactoryBot.create(
        :future_application_workshop,
        start_time: DateTime.now + 1.hours,
        end_time: DateTime.now + 2.hours
      )

    @past_application_workshop =
      FactoryBot.create(
        :past_application_workshop,
        start_time: DateTime.now - 2.hours,
        end_time: DateTime.now - 1.hours
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

    @application_template = ApplicationTemplate.create
    @true_false_question = FactoryBot.create(:true_false_question)
    @short_answer_question = FactoryBot.create(:short_answer_question)
    @long_answer_question = FactoryBot.create(:long_answer_question)
    @likert_question = FactoryBot.create(:likert_question)

    [
      @true_false_question,
      @short_answer_question,
      @long_answer_question,
      @likert_question
    ].each do |q|
      ApplicationTemplateQuestion.create(
        application_template_id: @application_template.id,
        question_id: q.id
      )
    end

    [
      @proposal_pending_workshop,
      @future_application_workshop,
      @past_application_workshop,
      @future_registration_workshop,
      @past_registration_workshop
    ].each do |workshop|
      WorkshopApplicationTemplate.create(
        workshop_id: workshop.id,
        application_template_id: @application_template.id
      )

      WorkshopFacilitator.create(
        workshop_id: workshop.id,
        facilitator_id: @facilitator_1.id
      )
    end
  end

  it 'displays an application form if in future and application required' do
    visit workshop_path(@future_application_workshop)

    expect(page).to have_content(@true_false_question.prompt.humanize)
    expect(page).to have_content(@short_answer_question.prompt.humanize)
    expect(page).to have_content(@long_answer_question.prompt.humanize)
    expect(page).to have_content(@likert_question.prompt.humanize)
  end

  it 'does not display an application if workshop is in the past and application required' do
    visit workshop_path(@past_application_workshop)

    expect(page).to_not have_content(@true_false_question.prompt.humanize)
    expect(page).to_not have_content(@short_answer_question.prompt.humanize)
    expect(page).to_not have_content(@long_answer_question.prompt.humanize)
    expect(page).to_not have_content(@likert_question.prompt.humanize)
  end

  it 'displays a registration form if workshop is in the future and registration required' do
    visit workshop_path(@future_registration_workshop)

    expect(page).to have_content(
      "Register for #{@future_registration_workshop.title}"
    )

    within '.form-inputs' do
      expect(page).to have_content('Name')
      expect(page).to have_content('Email')
    end

    # no application questions
    expect(page).to_not have_content(@true_false_question.prompt.humanize)
    expect(page).to_not have_content(@short_answer_question.prompt.humanize)
    expect(page).to_not have_content(@long_answer_question.prompt.humanize)
    expect(page).to_not have_content(@likert_question.prompt.humanize)
  end

  it 'does not display a registration form if workshop is in the past and registration required' do
    visit workshop_path(@past_registration_workshop)

    expect(page).to_not have_content(
      "Register for #{@past_registration_workshop.title}"
    )
    expect(page).to_not have_content(
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

    expect(page).to_not have_content(@proposal_pending_workshop.title)
  end

  it 'does not display a button to approve or reject a workshop if facilitator is not admin' do
    login_as @facilitator

    visit workshop_path(@proposal_pending_workshop)

    expect(page).to_not have_content('approve or reject?')
  end
end
