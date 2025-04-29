# frozen_string_literal: true

# TODO: - I haven't tested this

module FeedbackFormScheduler
  extend ActiveSupport::Concern

  included { after_action :schedule_feedback_emails, only: [:create] }

  private

  def schedule_feedback_emails
    FeedbackFormEmailJob.perform_at(
      @workshop_participant.workshop.end_time,
      {
        feedback_form_id: @workshop_participant.workshop.feedback_form.id,
        participant_id: @workshop_participant.participant.id
      }.stringify_keys
    )
  end
end
