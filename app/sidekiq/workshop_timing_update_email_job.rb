# frozen_string_literal: true

class WorkshopTimingUpdateEmailJob
  include Sidekiq::Job

  def perform(*args)
    ParticipantMailer.workshop_timing_update_email(
      args[0]['workshop_id'],
      args[0]['participant_id']
    ).deliver_now
  end
end
