# frozen_string_literal: true

class WorkshopsController < ApplicationController
  include Filterable

  before_action :set_workshop, only: %i[show edit update destroy]
  before_action :require_login, only: %i[new edit update destroy pending]

  # GET /workshops
  def index
    @workshops = Workshop.approved
  end

  def pending
    @workshops = Workshop.pending
  end

  # GET /workshops/1
  def show; end

  # GET /workshops/new
  def new; end

  # GET /workshops/1/edit
  def edit; end

  # PATCH/PUT /workshops/1
  def update
    respond_to do |format|
      if @workshop.update(workshop_params)
        format.turbo_stream do
          turbo_stream.replace 'group_attendance_form',
                               partial: 'group_attendance_form'
          turbo_stream.replace 'proposal_status', partial: 'proposal_status'
        end
        format.html do
          redirect_to @workshop, notice: 'Workshop was successfully updated.'
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workshops/1
  def destroy
    @workshop.destroy!

    respond_to do |format|
      format.html do
        redirect_to workshops_path,
                    status: :see_other,
                    notice: 'Workshop was successfully destroyed.'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_workshop
    @workshop = Workshop.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def workshop_params
    params.require(:workshop).permit(
      :title,
      :description,
      :start_time,
      :end_time,
      :location,
      :attendance_modality,
      :presentation_modality,
      :registration_modality,
      :in_person_location,
      :virtual_location,
      :proposal_status,
      :in_person_attendance_count,
      :virtual_attendance_count,
      attachments: [],
      facilitator_ids: []
    )
  end
end
