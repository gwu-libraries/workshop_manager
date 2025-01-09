module ParticipantNotifier
  extend ActiveSupport::Concern

  included do
    after_action :application_received_notification, only: [:apply]
    after_action :registration_received_notification, only: [:create]
    after_action :schedule_reminder_notifications, only: [:create]
    after_action :application_status_notification, only: [:update]
  end

  private

  def registration_received_notification
    if @workshop_participant.persisted?
      RegistrationReceivedEmailJob.perform_async(
        {
          workshop_id: @workshop_participant.workshop.id,
          participant_id: @workshop_participant.participant.id
        }.stringify_keys
      )
    end
  end

  def application_received_notification
    ApplicationReceivedEmailJob.perform_async(
      {
        workshop_id: @workshop_participant.workshop.id,
        participant_id: @workshop_participant.participant.id
      }.stringify_keys
    )
  end

  def application_status_notification
    if workshop_participant_params[:application_status] == 'accepted'
      ApplicationAcceptedEmailJob.perform_async(
        {
          workshop_id: @workshop_participant.workshop.id,
          participant_id: @workshop_participant.participant.id
        }.stringify_keys
      )
    elsif workshop_participant_params[:application_status] == 'rejected'
      ApplicationRejectedEmailJob.perform_async(
        {
          workshop_id: @workshop_participant.workshop.id,
          participant_id: @workshop_participant.participant.id
        }.stringify_keys
      )
    elsif workshop_participant_params[:application_status] == 'waitlisted'
      ApplicationWaitlistedEmailJob.perform_async(
        {
          workshop_id: @workshop_participant.workshop.id,
          participant_id: @workshop_participant.participant.id
        }.stringify_keys
      )
    end
  end

  def schedule_reminder_notifications
    if @workshop_participant.persisted?
      if reminder_option_params[:reminder_options].include? 'One week before'
        ReminderEmailOneWeekJob.perform_at(
          (@workshop_participant.workshop.start_time - 1.weeks).round,
          {
            workshop_id: @workshop_participant.workshop.id,
            participant_id: @workshop_participant.participant.id
          }.stringify_keys
        )
      end

      if reminder_option_params[:reminder_options].include? 'One day before'
        ReminderEmailOneDayJob.perform_at(
          (@workshop_participant.workshop.start_time - 1.days).round,
          {
            workshop_id: @workshop_participant.workshop.id,
            participant_id: @workshop_participant.participant.id
          }.stringify_keys
        )
      end

      if reminder_option_params[:reminder_options].include? 'One hour before'
        ReminderEmailOneHourJob.perform_at(
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
