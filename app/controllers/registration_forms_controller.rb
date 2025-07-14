# frozen_string_literal: true

class RegistrationFormsController < ApplicationController
  def create
    @form = RegistrationForm.new(params)

    respond_to do |format|
      if @form.save

        participant =
          Participant.create(
            name: @form.name,
            email: @form.email,
            workshop_id: @form.workshop_id,
            application_status: 'accepted'
          )

        RegistrationReceivedEmailJob.perform_async(
          {
            workshop_id: participant.workshop_id,
            participant_id: participant.id
          }.stringify_keys
        )

        FeedbackEmailJob.perform_at(
          (participant.workshop.end_time).round,
          {
            workshop_id: participant.workshop_id,
            participant_id: participant.id
          }.stringify_keys
        )

        if @form.reminder_options.include? 'One week before'
          ReminderEmailOneWeekJob.perform_at(
            (participant.workshop.start_time - 1.week).round,
            {
              workshop_id: participant.workshop_id,
              participant_id: participant.id
            }.stringify_keys
          )
        end

        if @form.reminder_options.include? 'One day before'
          ReminderEmailOneDayJob.perform_at(
            (participant.workshop.start_time - 1.day).round,
            {
              workshop_id: participant.workshop_id,
              participant_id: participant.id
            }.stringify_keys
          )
        end

        if @form.reminder_options.include? 'One hour before'
          ReminderEmailOneHourJob.perform_at(
            (participant.workshop.start_time - 1.hour).round,
            {
              workshop_id: participant.workshop_id,
              participant_id: participant.id
            }.stringify_keys
          )
        end

        format.turbo_stream do
          turbo_stream.replace 'registration_form',
                               partial: 'registration_received_notification'
        end
        format.html do
          redirect_to workshop_path(@form.workshop_id),
                      notice:
                        'Your registration was successful! Check your email for more information.'
        end
      else
        format.html do
          redirect_to workshop_path(@form.workshop_id),
                      status: :unprocessable_entity
        end
      end
    end
  end

  # def registration_form_params
  #   params.require(:participant_application_form).permit(
  #     :name,
  #     :email,
  #     :workshop_id,
  #   )
  # end
end
