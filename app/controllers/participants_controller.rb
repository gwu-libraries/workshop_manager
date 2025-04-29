# frozen_string_literal: true

class ParticipantsController < ApplicationController
  before_action :set_participant, only: %i[show edit update destroy]
  # before_action :require_login, only: %i[index show edit update destroy]

  # GET /participants
  def index
    @participants = Participant.all
  end

  # GET /participants/1
  def show; end

  # GET /participants/new
  def new
    @participant = Participant.new
  end

  # GET /participants/1/edit
  def edit; end

  # POST /participants
  def create
    @participant = Participant.new(participant_params)

    respond_to do |format|
      if @participant.save
        format.html do
          redirect_to @participant,
                      notice: 'Participant was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participants/1
  def update
    respond_to do |format|
      if @participant.update(participant_params)
        format.html do
          redirect_to @participant,
                      notice: 'Participant was successfully updated.'
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  def destroy
    @participant.destroy!

    respond_to do |format|
      format.html do
        redirect_to participants_path,
                    status: :see_other,
                    notice: 'Participant was successfully destroyed.'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_participant
    @participant = Participant.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def participant_params
    params.require(:participant).permit(:name, :email)
  end
end
