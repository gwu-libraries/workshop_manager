class WorkshopRejectedEmailJob
  include Sidekiq::Job
  # sidekiq_options queue: :mailer

  def perform(*args)
    ParticipantMailer.workshop_rejected_email(
      args[0]['workshop_id'],
      args[0]['participant_id']
    )
  end
end
