require 'rails_helper'

RSpec.describe 'workshops/index', type: :view do
  it 'does not show pending or rejected workshops on the main calendar' do
    workshop_1 = FactoryBot.create(:proposal_pending_workshop)
    workshop_2 = FactoryBot.create(:rejected_workshop)

    visit workshops_path

    expect(page).to_not have_content(workshop_1.title)
    expect(page).to_not have_content(workshop_2.title)
  end
end
