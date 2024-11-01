class FacilitatorsController < ApplicationController
  before_action :set_facilitator, only: %i[show edit update destroy]
  before_action :require_login,
                only: %i[index show new edit create update destroy]

  # GET /facilitators or /facilitators.json
  def index
    @facilitators = Facilitator.all
  end

  # GET /facilitators/1 or /facilitators/1.json
  def show
  end

  # GET /facilitators/new
  def new
    @facilitator = Facilitator.new
  end

  # GET /facilitators/1/edit
  def edit
  end

  # POST /facilitators or /facilitators.json
  def create
    require 'pry'
    binding.pry
    @facilitator = Facilitator.new(facilitator_params)

    respond_to do |format|
      if @facilitator.save
        format.html do
          redirect_to @facilitator,
                      notice: 'Facilitator was successfully created.'
        end
        format.json { render :show, status: :created, location: @facilitator }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @facilitator.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /facilitators/1 or /facilitators/1.json
  def update
    respond_to do |format|
      if @facilitator.update(facilitator_params)
        format.html do
          redirect_to @facilitator,
                      notice: 'Facilitator was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @facilitator }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @facilitator.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /facilitators/1 or /facilitators/1.json
  def destroy
    @facilitator.destroy!

    respond_to do |format|
      format.html do
        redirect_to facilitators_path,
                    status: :see_other,
                    notice: 'Facilitator was successfully destroyed.'
      end
      format.json { head :no_content }
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
