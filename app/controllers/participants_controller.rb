# frozen_string_literal: true

class ParticipantsController < ApplicationController
  # include FeedbackEmailScheduler

  before_action :set_participant, only: %i[update destroy]

  # after_action :application_received_notification, only: :apply
  # before_action :require_login,
  #               only: %i[ new edit create update destroy]

  # GET /participants/1/edit
  def edit; end

  # PATCH/PUT /participants/1
  def update
    respond_to do |format|
      if @participant.update(participant_params)
        format.turbo_stream do
          render "participant_attendance_status_form_#{@participant.id}",
                 partial: 'participants/attendance_status_form'
        end
        format.html { redirect_to workshop_path(@participant.workshop_id) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  def destroy
    @participant.destroy!

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream:
                 turbo_stream.remove("participant_#{@participant.id}")
      end
      format.html { render workshop_path(@participant.workshop.id) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_participant
    @participant = Participant.find(params[:id])
  end

  def application_received_notification
    nil unless @participant.persisted?
  end

  # Only allow a list of trusted parameters through.
  def participant_params
    params.require(:participant).permit(
      :workshop_id,
      :in_attendance,
      :name,
      :email,
      :application_status,
      reminder_options: []
    )
  end

  def reminder_option_params
    params.require(:reminder_options).permit(reminder_options: [])
  end
end
