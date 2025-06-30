# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'workshops/new' do
  it 'creates workshops with a status of "pending" by default' do
    facilitator_1 = FactoryBot.create(:facilitator)

    login_as(facilitator_1)

    visit new_workshop_path

    fill_in 'workshop_proposal_form_description', with: 'Really neat!'

    select 'virtual'

    fill_in 'workshop_proposal_form_virtual_location', with: 'zoom'
    fill_in 'workshop_proposal_form_in_person_location', with: 'Library'

    choose 'workshop_proposal_form_attendance_modality_individual'
    choose 'workshop_proposal_form_registration_modality_no_registration_required'

    click_button 'Submit'

    workshop = Workshop.last

    expect(workshop.proposal_status).to eq('pending')
  end
end
