# frozen_string_literal: true

class ParticipantMailer < ApplicationMailer
  include WorkshopsHelper

  # before_action :set_workshop
  # before_action :set_participant
  # before_action :set_ical_event

  def workshop_timing_update_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message = "Start or end time for #{@workshop.title} has changed!"

    ical = Icalendar::Calendar.new
    ical.event do |event|
      event.uid = @workshop.uuid
      event.dtstart = @workshop.start_time
      event.dtend = @workshop.end_time
      event.sequence = Time.now.to_i
      event.summary = @workshop.title
      event.description = @workshop.description
      event.location = @workshop.in_person_location
      event.organizer =
        Icalendar::Values::CalAddress.new(
          "MAILTO:#{ENV['GMAIL_USERNAME']}",
          cn: '"Workshops TEST"'
        )
      event.attendee =
        Icalendar::Values::CalAddress.new("mailto:#{@participant.email}")
    end

    ical.ip_method = 'REQUEST'

    attachments['invite.ics'] = {
      mime_type: 'text/calendar; method=REQUEST',
      content: ical.to_ical
    }

    mail(
      to: @participant.email,
      subject: "Time Update for #{@workshop.title}"
    ) do |format|
      format.text
      format.html
    end
  end

  def workshop_location_update_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message = "Location for #{@workshop.title} has changed!"

    ical = Icalendar::Calendar.new
    ical.event do |event|
      event.uid = @workshop.uuid
      event.dtstart = @workshop.start_time
      event.dtend = @workshop.end_time
      event.sequence = Time.now.to_i
      event.summary = @workshop.title
      event.description = @workshop.description
      event.location = @workshop.in_person_location
      event.organizer =
        Icalendar::Values::CalAddress.new(
          "MAILTO:#{ENV['GMAIL_USERNAME']}",
          cn: '"Workshops TEST"'
        )
      event.attendee =
        Icalendar::Values::CalAddress.new("mailto:#{@participant.email}")
    end

    ical.ip_method = 'REQUEST'

    attachments['invite.ics'] = {
      mime_type: 'text/calendar; method=REQUEST',
      content: ical.to_ical
    }

    mail(
      to: @participant.email,
      subject: "Location Update for #{@workshop.title}"
    ) do |format|
      format.text
      format.html
    end
  end

  def registration_received_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message = "Thank you for registering for #{@workshop.title}!"

    ical = Icalendar::Calendar.new
    ical.event do |event|
      event.uid = @workshop.uuid
      event.dtstart = @workshop.start_time
      event.dtend = @workshop.end_time
      event.sequence = Time.now.to_i
      event.summary = @workshop.title
      event.description = @workshop.description
      event.location = @workshop.in_person_location
      event.organizer =
        Icalendar::Values::CalAddress.new(
          "MAILTO:#{ENV['GMAIL_USERNAME']}",
          cn: '"Workshops TEST"'
        )
      event.attendee =
        Icalendar::Values::CalAddress.new(
          "mailto:#{@participant.email}",
          partstat: 'accepted'
        )
    end

    ical.ip_method = 'REQUEST'

    attachments['invite.ics'] = {
      mime_type: 'text/calendar; method=REQUEST',
      content: ical.to_ical
    }

    mail(
      to: @participant.email,
      subject: "Registered for #{@workshop.title}"
    ) do |format|
      format.text
      format.html
    end
  end

  def application_received_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message = "Application received for #{@workshop.title}"

    mail(
      to: @participant.email,
      subject: "Application for #{@workshop.title} received!"
    ) do |format|
      format.text
      format.html
    end
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
    ) do |format|
      format.text
      format.html
    end
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
    ) do |format|
      format.text
      format.html
    end
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
    ) do |format|
      format.text
      format.html
    end
  end

  def application_accepted_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message = "You have been accepted for #{@workshop.title}"
    ical = Icalendar::Calendar.new
    ical.event do |event|
      event.uid = @workshop.uuid
      event.dtstart = @workshop.start_time
      event.dtend = @workshop.end_time
      event.sequence = Time.now.to_i
      event.summary = @workshop.title
      event.description = @workshop.description
      event.location = @workshop.in_person_location
      event.organizer =
        Icalendar::Values::CalAddress.new(
          "MAILTO:#{ENV['GMAIL_USERNAME']}}",
          cn: '"Workshops TEST"'
        )
      event.attendee =
        Icalendar::Values::CalAddress.new(
          "mailto:#{@participant.email}",
          partstat: 'accepted'
        )
    end

    ical.ip_method = 'REQUEST'

    attachments['invite.ics'] = {
      mime_type: 'text/calendar; method=REQUEST',
      content: ical.to_ical
    }

    mail(
      to: @participant.email,
      subject: "Accepted: #{@workshop.title}"
    ) do |format|
      format.text
      format.html
    end
  end

  def application_rejected_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message = "You have been rejected for #{@workshop.title}"

    mail(
      to: @participant.email,
      subject: "Rejected: #{@workshop.title}"
    ) do |format|
      format.text
      format.html
    end
  end

  def application_waitlisted_email(workshop_id, participant_id)
    @workshop = Workshop.find(workshop_id)
    @participant = Participant.find(participant_id)
    @message = "You have been waitlisted for #{@workshop.title}"

    mail(
      to: @participant.email,
      subject: "Waitlisted: #{@workshop.title}"
    ) do |format|
      format.text
      format.html
    end
  end

  def feedback_form_email(feedback_form_id, participant_id)
    @feedback_form = FeedbackForm.find(feedback_form_id)
    @participant = Participant.find(participant_id)

    @message =
      "Please complete feedback form for #{@feedback_form.workshop.title}"

    mail(
      to: @participant.email,
      subject: "Feedback form for #{@feedback_form.workshop.title}"
    ) do |format|
      format.text
      format.html
    end
  end

  # private

  # def set_ical_event
  # end

  # def set_workshop
  # end

  # def set_participant
  # end
end
