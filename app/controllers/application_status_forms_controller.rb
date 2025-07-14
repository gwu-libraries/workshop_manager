# frozen_string_literal: true

class ApplicationStatusFormsController < ApplicationController
  # include FeedbackEmailScheduler

  def create
    @form = ApplicationStatusForm.new(params)

    respond_to do |format|
      if @form.save
        participant = Participant.find(@form.participant_id)
        workshop = Workshop.find(participant.workshop_id)
        
        participant.update(application_status: @form.application_status)

        send_application_status_notification

        if @form.application_status == 'accepted'
          FeedbackEmailJob.perform_at(
            (workshop.end_time).round,
            {
              workshop_id: workshop.id,
              participant_id: participant.id
            }.stringify_keys
          )
        end

        format.turbo_stream do
          turbo_stream.destroy "participant_application_status_form_#{@form.participant_id}"
        end
        format.html { redirect_to workshop_path(@form.workshop_id) }
      end
    end
  end

  private

  def send_application_status_notification
    case @form.application_status
    when 'accepted'
      ApplicationAcceptedEmailJob.perform_async(
        {
          workshop_id: @form.workshop_id,
          participant_id: @form.participant_id
        }.stringify_keys
      )
    when 'rejected'
      ApplicationRejectedEmailJob.perform_async(
        {
          workshop_id: @form.workshop_id,
          participant_id: @form.participant_id
        }.stringify_keys
      )
    when 'waitlisted'
      ApplicationWaitlistedEmailJob.perform_async(
        {
          workshop_id: @form.workshop_id,
          participant_id: @form.participant_id
        }.stringify_keys
      )
    end
  end
end
