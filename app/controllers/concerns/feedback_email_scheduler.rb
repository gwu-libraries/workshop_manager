# frozen_string_literal: true

# TODO: - I haven't tested this

# module FeedbackEmailScheduler
#   extend ActiveSupport::Concern

#   included { after_action :schedule_feedback_emails, only: [:create] }

#   private

#   def schedule_feedback_emails
#     FeedbackEmailJob.perform_at(
#       @participant.workshop.end_time,
#       { participant_id: @participant.id }.stringify_keys
#     )
#   end
# end
