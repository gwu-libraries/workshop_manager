# Preview all emails at http://localhost:3000/rails/mailers/participant_mailer
class ParticipantMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/participant_mailer/workshop_registration_email
  def workshop_registration_email
    participant = Participant.last
    workshop = Workshop.last
    ParticipantMailer.workshop_registration_email(workshop.id, participant.id)
  end

  def workshop_reminder_email_one_week
    participant = Participant.last
    workshop = Workshop.last

    ParticipantMailer.workshop_reminder_email_one_week(
      workshop.id,
      participant.id
    )
  end

  def workshop_reminder_email_one_day
    participant = Participant.last
    workshop = Workshop.last

    ParticipantMailer.workshop_reminder_email_one_day(
      workshop.id,
      participant.id
    )
  end

  def workshop_reminder_email_one_hour
    participant = Participant.last
    workshop = Workshop.last

    ParticipantMailer.workshop_reminder_email_one_hour(
      workshop.id,
      participant.id
    )
  end
end
