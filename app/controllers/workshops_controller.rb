# frozen_string_literal: true

class WorkshopsController < ApplicationController
  include Filterable

  before_action :set_workshop, only: %i[show edit update destroy]
  before_action :require_login, only: %i[new edit create update destroy pending]

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
  def new
    @workshop = Workshop.new
  end

  # GET /workshops/1/edit
  def edit; end

  # POST /workshops
  def create
    @workshop = Workshop.new(workshop_params)

    workshop_params[:facilitator_ids]
      .reject(&:empty?)
      .each do |facilitator_id|
        WorkshopFacilitator.create(
          workshop_id: @workshop.id,
          facilitator_id: facilitator_id
        )
      end

    if @workshop.save
      if @workshop.registration_modality == 'application_required'
        @application_form = ApplicationForm.create(workshop_id: @workshop.id)
      end

      @feedback_form = FeedbackForm.create(workshop_id: @workshop.id) if @workshop.use_feedback_form?
    end

    respond_to do |format|
      if @workshop.save
        if @workshop.registration_modality == 'application_required'
          format.html { redirect_to application_form_path(@application_form) }
        elsif @workshop.use_feedback_form?
          format.html { redirect_to edit_feedback_form_path(@feedback_form) }
        else
          format.html do
            redirect_to @workshop, notice: 'Workshop was successfully created.'
          end
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

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
      :use_feedback_form,
      attachments: [],
      facilitator_ids: []
    )
  end
end
