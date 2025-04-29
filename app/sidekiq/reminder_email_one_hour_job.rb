# frozen_string_literal: true

class ReminderEmailOneHourJob
  include Sidekiq::Job
  # sidekiq_options queue: :mailer

  def perform(*args)
    ParticipantMailer.reminder_email_one_hour(
      args[0]['workshop_id'],
      args[0]['participant_id']
    ).deliver_now
  end
end
