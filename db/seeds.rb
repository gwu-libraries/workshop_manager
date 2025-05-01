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

puts 'Seeding development database...'

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
not_fac =
  FactoryBot.create(
    :facilitator,
    email: 'notfacilitator@example.com',
    password: 'password'
  )

# Create 4 other facilitators
facilitators = []
20.times { facilitators << FactoryBot.create(:facilitator) }

past_workshops_registration_required = []
5.times do
  past_workshops_registration_required << FactoryBot.create(
    :past_registration_workshop
  )
end

past_workshops_application_required = []
5.times do
  past_workshops_application_required << FactoryBot.create(
    :past_application_workshop
  )
end

past_workshops_open = []
5.times { past_workshops_open << FactoryBot.create(:past_open_workshop) }

future_workshops_registration_required = []
5.times do
  future_workshops_registration_required << FactoryBot.create(
    :future_registration_workshop
  )
end

future_workshops_application_required = []
5.times do
  future_workshops_application_required << FactoryBot.create(
    :future_application_workshop
  )
end

future_workshops_open = []
5.times { future_workshops_open << FactoryBot.create(:future_open_workshop) }

# Assign two facilitators to each workshop
Workshop.all.each do |workshop|
  facilitators
    .sample(2)
    .each do |facilitator|
      WorkshopFacilitator.create(
        workshop_id: workshop.id,
        facilitator_id: facilitator.id
      )
    end

  WorkshopFacilitator.create(workshop_id: workshop.id, facilitator_id: fac.id)
end

# Create 30 participants
participants = []
30.times { participants << FactoryBot.create(:participant) }

# Add application_forms to workshops that require an application
[
  past_workshops_application_required,
  future_workshops_application_required
].flatten.each do |workshop|
  af = workshop.application_form
  questions = []
  2.times do
    questions << FactoryBot.create(:short_answer_question)
    questions << FactoryBot.create(:long_answer_question)
    questions << FactoryBot.create(:likert_question)
    questions << FactoryBot.create(:true_false_question)
  end

  questions.each do |q|
    ApplicationFormQuestion.create(
      question_id: q.id,
      application_form_id: af.id
    )
  end
end

future_workshops_application_required.each do |workshop|
  questions = workshop.application_form.questions

  participants = []
  10.times { participants << FactoryBot.create(:participant) }

  participants.each do |participant|
    application_responses = {}
    questions.each do |q|
      application_responses[q.prompt] = Faker::Lorem.sentence
    end
    WorkshopParticipant.create(
      workshop_id: workshop.id,
      participant_id: participant.id,
      application_status: 'pending',
      application_responses: application_responses
    )
  end
end

10.times { FactoryBot.create(:proposal_pending_workshop) }

4.times do
  track = FactoryBot.create(:approved_track)

  ws = Workshop.all.sample(5)

  ws.each do |workshop|
    TrackWorkshop.create(track_id: track.id, workshop_id: workshop.id)
  end
end

4.times do
  track = FactoryBot.create(:pending_track)

  ws = Workshop.all.sample(5)

  ws.each do |workshop|
    TrackWorkshop.create(track_id: track.id, workshop_id: workshop.id)
  end
end

FeedbackForm.all.each do |ff|
  questions = []
  questions << FactoryBot.create(:short_answer_question)
  questions << FactoryBot.create(:long_answer_question)
  questions << FactoryBot.create(:likert_question)
  questions << FactoryBot.create(:true_false_question)

  questions.each do |question|
    FeedbackFormQuestion.create(
      feedback_form_id: ff.id,
      question_id: question.id
    )
  end
end
# Add participants to past workshops, randomize if they are marked as in_attendance or not
# Add random selection of facilitators to past workshops
# past_workshops.each do |pw|
#   participants
#     .sample(rand(participants.count))
#     .each do |part|
#       WorkshopParticipant.create(
#         workshop_id: pw.id,
#         participant_id: part.id,
#         in_attendance: [true, false].sample
#       )
#     end
# end

# Add participants to future workshops, mark as not in_attendance by default
# Add random selection of facilitators to future workshops
# future_workshops.each do |fw|
#   participants
#     .sample(rand(participants.count))
#     .each do |part|
#       WorkshopParticipant.create(
#         workshop_id: fw.id,
#         participant_id: part.id,
#         in_attendance: false
#       )
#     end
# end

# future_workshops.each do |workshop|
#   if workshop.registration_modality == 'application_required'
#     questions = workshop.application_form.questions
#     workshop.workshop_participants.each do |wp|
#       responses = {}
#       questions.each { |q| responses[q.prompt] = Faker::Lorem.sentence }
#       wp.application_responses = responses
#       wp.application_status = 'pending'
#     end
#   end
# end
