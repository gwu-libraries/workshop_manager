# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'workshops/index', type: :view do
  it 'does not show pending or rejected workshops on the main calendar' do
    workshop_1 = FactoryBot.create(:proposal_pending_workshop)
    workshop_2 = FactoryBot.create(:rejected_workshop)

    visit workshops_path

    expect(page).not_to have_content(workshop_1.title)
    expect(page).not_to have_content(workshop_2.title)
  end

  it 'does show approved workshops' do
    workshop_1 =
      FactoryBot.create(
        :future_application_workshop,
        start_time: DateTime.now + 1.hour,
        end_time: DateTime.now + 2.hours
      )
    workshop_2 =
      FactoryBot.create(
        :future_registration_workshop,
        start_time: DateTime.now + 3.hours,
        end_time: DateTime.now + 4.hours
      )

    visit workshops_path

    expect(page).to have_content(workshop_1.title)
    expect(page).to have_content(workshop_2.title)
  end
end
