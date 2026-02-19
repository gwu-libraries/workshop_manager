# frozen_string_literal: true

class FeedbackEmailJob
  include Sidekiq::Job

  def perform(*args)
    ParticipantMailer.feedback_email(
      args[0]['participant_id'],
      args[0]['workshop_id']
    ).deliver_now
  end
end
