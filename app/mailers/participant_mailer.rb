class ParticipantMailer < ApplicationMailer
  include WorkshopsHelper
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.participant_mailer.workshop_registration_email.subject
  #
  def registration_received_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message = "Thank you for registering for #{@workshop.title}!"

    mail(to: @participant.email, subject: "Registered for #{@workshop.title}")
  end

  def application_received_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message = "Application received for #{@workshop.title}"

    mail(
      to: @participant.email,
      subject: "Application for #{@workshop.title} received!"
    )
  end

  def reminder_email_one_week(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message =
      "Reminder that #{@workshop.title} is in one week on #{human_readable_date(@workshop.start_time)} at #{human_readable_time(@workshop.start_time)}"

    mail(
      to: @participant.email,
      subject:
        "Reminder: #{@workshop.title} next week on #{human_readable_date(@workshop.start_time)} at #{human_readable_time(@workshop.start_time)}"
    )
  end

  def reminder_email_one_day(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message =
      "Reminder that #{@workshop.title} is tomorrow at #{human_readable_time(@workshop.start_time)}"

    mail(
      to: @participant.email,
      subject:
        "Reminder: #{@workshop.title} tomorrow at #{human_readable_time(@workshop.start_time)}"
    )
  end

  def reminder_email_one_hour(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message =
      "Reminder that #{@workshop.title} is in one hour at #{human_readable_time(@workshop.start_time)}"

    mail(
      to: @participant.email,
      subject:
        "Reminder: #{@workshop.title} today at #{human_readable_time(@workshop.start_time)}"
    )
  end

  def application_waitlisted_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message = "You have been waitlisted for #{@workshop.title}"

    mail(to: @participant.email, subject: "Waitlisted: #{@workshop.title}")
  end

  def application_accepted_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message = "You have been accepted for #{@workshop.title}"

    mail(to: @participant.email, subject: "Accepted: #{@workshop.title}")
  end

  def application_rejected_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message = "You have been rejected for #{@workshop.title}"

    mail(to: @participant.email, subject: "Rejected: #{@workshop.title}")
  end
end
