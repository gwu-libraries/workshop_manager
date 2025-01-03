# Preview all emails at http://localhost:3000/rails/mailers/participant_mailer
class ParticipantMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/participant_mailer/workshop_registration_email
  def registration_received_email
    participant = Participant.last
    workshop = Workshop.last
    ParticipantMailer.registration_received_email(workshop.id, participant.id)
  end

  def application_received_email
    participant = Participant.last
    workshop = Workshop.last

    ParticipantMailer.application_received_email(workshop.id, participant.id)
  end

  def application_accepted_email
    participant = Participant.last
    workshop = Workshop.last

    ParticipantMailer.application_accepted_email(workshop.id, participant.id)
  end

  def application_rejected_email
    participant = Participant.last
    workshop = Workshop.last

    ParticipantMailer.application_rejected_email(workshop.id, participant.id)
  end

  def application_waitlisted_email
    participant = Participant.last
    workshop = Workshop.last

    ParticipantMailer.application_waitlisted_email(workshop.id, participant.id)
  end

  def reminder_email_one_week
    participant = Participant.last
    workshop = Workshop.last

    ParticipantMailer.reminder_email_one_week(workshop.id, participant.id)
  end

  def reminder_email_one_day
    participant = Participant.last
    workshop = Workshop.last

    ParticipantMailer.reminder_email_one_day(workshop.id, participant.id)
  end

  def reminder_email_one_hour
    participant = Participant.last
    workshop = Workshop.last

    ParticipantMailer.reminder_email_one_hour(workshop.id, participant.id)
  end
end
