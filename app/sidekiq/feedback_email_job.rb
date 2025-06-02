# frozen_string_literal: true

class FeedbackEmailJob
  include Sidekiq::Job

  def perform(*_arg)
    ParticipantMailer.feedback_email(args[0]['participant_id']).deliver_now
  end
end
