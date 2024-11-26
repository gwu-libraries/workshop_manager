require 'rails_helper'

RSpec.describe 'workshops/new' do
  it 'creates workshops with a status of "pending" by default' do
    facilitator_1 = FactoryBot.create(:facilitator)

    login_as(facilitator_1)

    visit new_workshop_path

    fill_in 'Title', with: 'My Cool Workshop'
    fill_in 'Description', with: 'Really neat!'

    choose 'virtual'

    fill_in 'Virtual location', with: 'zoom'
    fill_in 'In person location', with: 'Library'

    choose 'no_registration_required'

    click_button 'Propose Workshop'

    workshop = Workshop.last

    expect(workshop.proposal_status).to eq('pending')
  end
end
