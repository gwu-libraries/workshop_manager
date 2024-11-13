module WorkshopParticipantNotifier
  extend ActiveSupport::Concern

  included do
    after_action :workshop_participant_registration_notification,
                 only: [:create]
    after_action :schedule_workshop_reminder_notification, only: [:create]
  end

  private

  def workshop_participant_registration_notification
    if @workshop_participant.persisted?
      WorkshopRegistrationEmailJob.perform_async(
        {
          workshop_id: @workshop_participant.workshop.id,
          participant_id: @workshop_participant.participant.id
        }.stringify_keys
      )
    end
  end

  def schedule_workshop_reminder_notification
    if @workshop_participant.persisted?
      WorkshopReminderEmailJob.perform_at(
        @workshop_participant.workshop.start_time - 1.hour,
        {
          workshop_id: @workshop_participant.workshop.id,
          participant_id: @workshop_participant.participant.id
        }.stringify_keys
      )
    end
  end
end
