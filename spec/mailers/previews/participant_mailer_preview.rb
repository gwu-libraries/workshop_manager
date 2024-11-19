# Preview all emails at http://localhost:3000/rails/mailers/participant_mailer
class ParticipantMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/participant_mailer/workshop_registration_email
  def workshop_registration_email
    participant = FactoryBot.create(:participant)
    workshop = FactoryBot.create(:future_workshop)
    ParticipantMailer.workshop_registration_email(workshop.id, participant.id)
  end
end
