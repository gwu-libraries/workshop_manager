# frozen_string_literal: true

module ReminderEmailScheduler
  extend ActiveSupport::Concern

  included { after_action :schedule_reminder_notifications, only: [:create] }

  private

  def schedule_reminder_notifications
    return unless @workshop_participant.persisted?

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
