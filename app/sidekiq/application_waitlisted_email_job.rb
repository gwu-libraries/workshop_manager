# frozen_string_literal: true

class ApplicationWaitlistedEmailJob
  include Sidekiq::Job
  # sidekiq_options queue: :mailer

  def perform(*args)
    ParticipantMailer.application_waitlisted_email(
      args[0]['workshop_id'],
      args[0]['participant_id']
    ).deliver_now
  end
end
