# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "workshop application questions" do
    
    before(:each) do
        @facilitator_1 = FactoryBot.create(:facilitator)
        @workshop_1 = FactoryBot.create(:future_registration_workshop)

        login_as @facilitator_1

        visit new_workshop_path

        fill_in 'workshop_proposal_form_description', with: 'Really neat!'

        select 'virtual'

        fill_in 'workshop_proposal_form_virtual_location', with: 'zoom'
        fill_in 'workshop_proposal_form_in_person_location', with: 'Library'

        choose 'workshop_proposal_form_attendance_modality_individual'
    end
    
    xit 'redirects from workshop proposal form to form for application questions if application required' do
        choose 'workshop_proposal_form_registration_modality_application_required'
    
        click_button 'Submit'

        # save_and_open_page

        expect(current_path).to eq()

        # require 'pry'; binding.pry
    end
    
end