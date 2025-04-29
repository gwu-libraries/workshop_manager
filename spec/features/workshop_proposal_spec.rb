# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'proposing a new workshop' do
  it 'works' do
    # sign in as facilitator, create a workshop
    facilitator_1 = FactoryBot.create(:facilitator)
    admin_1 = FactoryBot.create(:admin)

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

    # check presence on 'pending' page
    visit '/workshops/pending'

    expect(page).to have_content(workshop.title)

    # check lack of presence on main page

    visit '/workshops'

    expect(page).to_not have_content(workshop.title)

    # check lack of approval buttons on workshop page

    visit "/workshops/#{workshop.id}"

    expect(page).to_not have_content(
      'Workshop proposal status is pending - approve or reject?'
    )

    # sign out, then sign as as admin
    click_button 'Sign out'

    login_as(admin_1)

    # check presence of approval button as admin

    visit "/workshops/#{workshop.id}"

    expect(page).to have_content(
      'Workshop proposal status is pending - approve or reject?'
    )

    click_button 'Approve this workshop'

    # check lack of presence on pending page

    visit '/workshops/pending'

    expect(page).to_not have_content(workshop.title)

    # check presence on main page

    visit '/workshops'

    expect(page).to have_content(workshop.title)
  end
end

# As an facilitator
# When I visit the new workshop page and complete the fields
# and visit the workshops index
# and select the "proposed workshops" calendar
# I can see the title of the workshop I submitted

# As an administrator
# When a facilitator submits the workshop form
# I can see a link to it on the "proposed workshops" calendar
# and I have the option to approve it or reject it
# If approved - I can see it on the workshops calendar
