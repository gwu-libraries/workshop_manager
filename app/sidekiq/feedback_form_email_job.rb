# frozen_string_literal: true

class FeedbackFormEmailJob
  include Sidekiq::Job

  def perform(*_arg)
    ParticipantMailer.feedback_form_email(
      args[0]['feedback_form_id'],
      args[0]['participant_id']
    ).deliver_now
  end
end
