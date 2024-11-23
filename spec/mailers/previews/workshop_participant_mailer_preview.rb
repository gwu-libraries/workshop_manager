# Preview all emails at http://localhost:3000/rails/mailers/workshop_participant_mailer
class WorkshopParticipantMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/workshop_participant_mailer/workshop_registration_email
  def workshop_registration_email
    WorkshopParticipantMailer.workshop_registration_email
  end

end
