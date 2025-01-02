class ApplicationReceivedEmailJob
  include Sidekiq::Job

  def perform(*args)
    ParticipantMailer.application_received_email(
      args[0]['workshop_id'],
      args[0]['participant_id']
    )
  end
end
