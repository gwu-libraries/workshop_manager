class WorkshopReminderEmailOneHourJob
  include Sidekiq::Job
  # sidekiq_options queue: :mailer

  def perform(*args)
    ParticipantMailer.workshop_reminder_email_one_hour(
      args[0]['workshop_id'],
      args[0]['participant_id']
    )
  end
end
