class ParticipantMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.participant_mailer.workshop_registration_email.subject
  #
  def workshop_registration_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message = "Thank you for registering for #{@workshop.title}!"

    mail(to: @participant.email, subject: "Registered for #{@workshop.title}")
  end

  def workshop_reminder_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message =
      "Reminder that #{@workshop.title} is today at #{human_readable_time(@workshop.start_time)}"

    mail(
      to: @participant.email,
      subject:
        "Reminder: #{@workshop.title} at #{human_readable_time(@workshop.start_time)}"
    )
  end

  def workshop_waitlisted_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message = "You have been waitlisted for #{@workshop.title}"

    mail(to: @participant.email, subject: "Waitlisted: #{@workshop.title}")
  end

  def workshop_accepted_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message = "You have been accepted for #{@workshop.title}"

    mail(to: @participant.email, subject: "Accepted: #{@workshop.title}")
  end

  def workshop_rejected_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message = "You have been rejected for #{@workshop.title}"

    mail(to: @participant.email, subject: "Rejected: #{@workshop.title}")
  end
end
