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

admin =
  FactoryBot.create(
    :facilitator,
    email: 'admin@example.com',
    password: 'pjassword'
  )

facilitators = []
4.times { facilitators << FactoryBot.create(:facilitator) }

current_workshop = FactoryBot.create(:current_workshop)

past_workshops = []
10.times { past_workshops << FactoryBot.create(:past_workshop) }

future_workshops = []
10.times { future_workshops << FactoryBot.create(:future_workshop) }

participants = []
30.times { participants << FactoryBot.create(:participant) }

WorkshopFacilitator.create(
  facilitator_id: admin.id,
  workshop_id: current_workshop.id
)

past_workshops.each do |pw|
  participants
    .sample(rand(participants.count))
    .each do |part|
      WorkshopParticipant.create(workshop_id: pw.id, participant_id: part.id)
    end

  facilitators
    .sample(rand(facilitators.count))
    .each do |fac|
      WorkshopFacilitator.create(workshop_id: pw.id, facilitator_id: fac.id)
    end
end

future_workshops.each do |fw|
  participants
    .sample(rand(participants.count))
    .each do |part|
      WorkshopParticipant.create(workshop_id: fw.id, participant_id: part.id)
    end

  facilitators
    .sample(rand(facilitators.count))
    .each do |fac|
      WorkshopFacilitator.create(workshop_id: fw.id, facilitator_id: fac.id)
    end
end

tracks = []
5.times { tracks << FactoryBot.create(:track) }

tracks.each do |t|
  past_workshops
    .sample(rand(past_workshops.count))
    .each { |pw| TrackWorkshop.create(track_id: t.id, workshop_id: pw.id) }

  future_workshops
    .sample(rand(future_workshops.count))
    .each { |fw| TrackWorkshop.create(track_id: t.id, workshop_id: fw.id) }
end
