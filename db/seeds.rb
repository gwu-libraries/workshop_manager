# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

Rails.logger.debug 'Seeding development database...'

# Create an admin user
FactoryBot.create(:admin, email: 'admin@example.com', password: 'password')

# this user is added as a facilitator to all workshops
fac =
  FactoryBot.create(
    :facilitator,
    email: 'facilitator@example.com',
    password: 'password'
  )

# this user is NOT added to any workshops as a facilitator
FactoryBot.create(
  :facilitator,
  email: 'notfacilitator@example.com',
  password: 'password'
)

# Create 20 other facilitators
facilitators = []
20.times { facilitators << FactoryBot.create(:facilitator) }

# Create 5 workshops requiring registration that have already occurred
past_workshops_registration_required = []
5.times do
  past_workshops_registration_required << FactoryBot.create(
    :past_registration_workshop
  )
end

# Create 5 workshops requiring application that have already occurred
past_workshops_application_required = []
5.times do
  past_workshops_application_required << FactoryBot.create(
    :past_application_workshop
  )
end

# Create 5 open workshops that have already occurred
past_workshops_open = []
5.times { past_workshops_open << FactoryBot.create(:past_open_workshop) }

# Create 5 workshops requiring registration that are in the future
future_workshops_registration_required = []
5.times do
  future_workshops_registration_required << FactoryBot.create(
    :future_registration_workshop
  )
end

# Create 5 workshops requiring application that are in the future
future_workshops_application_required = []
5.times do
  future_workshops_application_required << FactoryBot.create(
    :future_application_workshop
  )
end

# Create 5 open workshops that are in the future
future_workshops_open = []
5.times { future_workshops_open << FactoryBot.create(:future_open_workshop) }

# Assign two non-descript facilitators to each workshop
Workshop.all.find_each do |workshop|
  facilitators
    .sample(2)
    .each do |facilitator|
      WorkshopFacilitator.create(
        workshop_id: workshop.id,
        facilitator_id: facilitator.id
      )
    end

  # Assign the facilitator@example.com account to all workshops
  WorkshopFacilitator.create(workshop_id: workshop.id, facilitator_id: fac.id)

  # Create 10 participants for each workshop
  10.times { FactoryBot.create(:participant, workshop_id: workshop.id) }
end

# create an application question of each type for workshops requiring applications
Workshop.application_required.each do |workshop|
  FactoryBot.create(:aq_true_false_question, workshop_id: workshop.id)
  FactoryBot.create(:aq_short_answer_question, workshop_id: workshop.id)
  FactoryBot.create(:aq_long_answer_question, workshop_id: workshop.id)
  FactoryBot.create(:aq_likert_question, workshop_id: workshop.id)
end

# create four approved tracks, add five approved workshops to the track
4.times do
  track = FactoryBot.create(:approved_track)

  ws = Workshop.approved.sample(5)

  ws.each do |workshop|
    TrackWorkshop.create(track_id: track.id, workshop_id: workshop.id)
  end
end

# Create four pending tracks, add five approved workshops to the track
4.times do
  track = FactoryBot.create(:pending_track)

  ws = Workshop.approved.sample(5)

  ws.each do |workshop|
    TrackWorkshop.create(track_id: track.id, workshop_id: workshop.id)
  end
end

Workshop.all.find_each do |workshop|
  FactoryBot.create(:fq_true_false_question, workshop_id: workshop.id)
  FactoryBot.create(:fq_short_answer_question, workshop_id: workshop.id)
  FactoryBot.create(:fq_long_answer_question, workshop_id: workshop.id)
  FactoryBot.create(:fq_likert_question, workshop_id: workshop.id)
end
