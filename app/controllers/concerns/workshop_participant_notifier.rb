module WorkshopParticipantNotifier
  extend ActiveSupport::Concern

  included do
    after_action :workshop_participant_registration_notification,
                 only: [:create]
    after_action :schedule_workshop_reminder_notification, only: [:create]
    after_action :workshop_application_status_notification, only: [:update]
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

  def workshop_application_status_notification
    if workshop_participant_params[:application_status] == 'accepted'
      WorkshopAcceptedEmailJob.perform_async(
        {
          workshop_id: @workshop_participant.workshop.id,
          participant_id: @workshop_participant.participant.id
        }.stringify_keys
      )
    elsif workshop_participant_params[:application_status] == 'rejected'
      WorkshopRejectedEmailJob.perform_async(
        {
          workshop_id: @workshop_participant.workshop.id,
          participant_id: @workshop_participant.participant.id
        }.stringify_keys
      )
    elsif workshop_participant_params[:application_status] == 'waitlisted'
      WorkshopWaitlistedEmailJob.perform_async(
        {
          workshop_id: @workshop_participant.workshop.id,
          participant_id: @workshop_participant.participant.id
        }.stringify_keys
      )
    end
  end

  def schedule_workshop_reminder_notification
    if @workshop_participant.persisted?
      if reminder_option_params[:reminder_options].include? 'One week before'
        WorkshopReminderEmailOneWeekJob.perform_at(
          (@workshop_participant.workshop.start_time - 1.weeks).round,
          {
            workshop_id: @workshop_participant.workshop.id,
            participant_id: @workshop_participant.participant.id
          }.stringify_keys
        )
      end

      if reminder_option_params[:reminder_options].include? 'One day before'
        WorkshopReminderEmailOneDayJob.perform_at(
          (@workshop_participant.workshop.start_time - 1.days).round,
          {
            workshop_id: @workshop_participant.workshop.id,
            participant_id: @workshop_participant.participant.id
          }.stringify_keys
        )
      end

      if reminder_option_params[:reminder_options].include? 'One hour before'
        WorkshopReminderEmailOneHourJob.perform_at(
          (@workshop_participant.workshop.start_time - 1.hours).round,
          {
            workshop_id: @workshop_participant.workshop.id,
            participant_id: @workshop_participant.participant.id
          }.stringify_keys
        )
      end
    end
  end
end
