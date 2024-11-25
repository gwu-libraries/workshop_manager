class WorkshopParticipantsController < ApplicationController
  include WorkshopParticipantNotifier

  before_action :set_workshop_participant, only: %i[show edit update destroy]
  # before_action :require_login,
  #               only: %i[index show new edit create update destroy]

  # GET /workshop_participants or /workshop_participants.json
  def index
    @workshop_participants = WorkshopParticipant.all
  end

  # GET /workshop_participants/1 or /workshop_participants/1.json
  def show
  end

  # GET /workshop_participants/new
  def new
    @workshop_participant = WorkshopParticipant.new
  end

  # GET /workshop_participants/1/edit
  def edit
  end

  def apply # no one is happy about this, fix it, but whatever for now. Should be part of "Application" and "WorkshopParticipantApplication"
    @participant =
      Participant.find_or_create_by(
        name: params[:workshop_participants][:name],
        email: params[:workshop_participants][:email]
      )

    application_responses = {}

    application_responses =
      params[:workshop_participants]
        .except(:email, :name, :workshop_id)
        .each { |key, value| application_responses[key] = value }

    @workshop_participant =
      WorkshopParticipant.create(
        workshop_id: params[:workshop_participants][:workshop_id],
        participant_id: @participant.id,
        application_status: 'pending',
        application_responses: application_responses
      )

    respond_to do |format|
      if @workshop_participant.save
        format.html do
          redirect_to workshop_path(@workshop_participant.workshop),
                      notice:
                        'Your application is pending! Check your email for more information.'
        end
        format.json do
          render :show, status: :created, location: @workshop_participant
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @workshop_participant.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # POST /workshop_participants or /workshop_participants.json
  def create # this is used for registering, not applying
    @participant =
      Participant.find_or_create_by(
        name: workshop_participant_params[:name],
        email: workshop_participant_params[:email]
      )

    @workshop_participant =
      WorkshopParticipant.new(
        workshop_id: workshop_participant_params[:workshop_id],
        participant_id: @participant.id,
        application_status: 'accepted'
      )

    respond_to do |format|
      if @workshop_participant.save
        format.html do
          redirect_to workshop_path(@workshop_participant.workshop),
                      notice:
                        "You're signed up! Check your email for more information."
        end
        format.json do
          render :show, status: :created, location: @workshop_participant
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @workshop_participant.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /workshop_participants/1 or /workshop_participants/1.json
  def update
    respond_to do |format|
      if @workshop_participant.update(workshop_participant_params)
        format.turbo_stream do
          render "workshop_participant_attendance_form_#{@workshop_participant.id}",
                 partial: 'workshop_participants/attendance_form'
        end
        format.html { render workshop_path(@workshop_participant.workshop_id) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @workshop_participant.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /workshop_participants/1 or /workshop_participants/1.json
  def destroy
    @workshop_participant.destroy!

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream:
                 turbo_stream.remove(
                   "participant_#{@workshop_participant.participant_id}"
                 )
      end
      format.html { render workshop_path(@workshop_participant.workshop_id) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_workshop_participant
    @workshop_participant = WorkshopParticipant.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def workshop_participant_params
    params.require(:workshop_participant).permit(
      :workshop_id,
      :participant_id,
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
