# frozen_string_literal: true

class FacilitatorsController < ApplicationController
  before_action :set_facilitator, only: %i[show edit update destroy]
  before_action :require_login,
                only: %i[index show new edit create update destroy]

  # GET /facilitators
  def index
    @facilitators = Facilitator.all
  end

  # GET /facilitators/1
  def show; end

  # GET /facilitators/new
  def new
    @facilitator = Facilitator.new
  end

  # GET /facilitators/1/edit
  def edit; end

  # POST /facilitators
  def create
    @facilitator = Facilitator.new(facilitator_params)

    respond_to do |format|
      if @facilitator.save
        format.html do
          redirect_to @facilitator,
                      notice: 'Facilitator was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facilitators/1
  def update
    respond_to do |format|
      if @facilitator.update(facilitator_params)
        format.html do
          redirect_to @facilitator,
                      notice: 'Facilitator was successfully updated.'
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facilitators/1
  def destroy
    @facilitator.destroy!

    respond_to do |format|
      format.html do
        redirect_to facilitators_path,
                    status: :see_other,
                    notice: 'Facilitator was successfully destroyed.'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_facilitator
    @facilitator = Facilitator.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def facilitator_params
    params.fetch(:facilitator, {})
  end
end
