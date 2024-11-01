class WorkshopFacilitatorsController < ApplicationController
  before_action :set_workshop_facilitator, only: %i[ show edit update destroy ]

  # GET /workshop_facilitators or /workshop_facilitators.json
  def index
    @workshop_facilitators = WorkshopFacilitator.all
  end

  # GET /workshop_facilitators/1 or /workshop_facilitators/1.json
  def show
  end

  # GET /workshop_facilitators/new
  def new
    @workshop_facilitator = WorkshopFacilitator.new
  end

  # GET /workshop_facilitators/1/edit
  def edit
  end

  # POST /workshop_facilitators or /workshop_facilitators.json
  def create
    @workshop_facilitator = WorkshopFacilitator.new(workshop_facilitator_params)

    respond_to do |format|
      if @workshop_facilitator.save
        format.html { redirect_to @workshop_facilitator, notice: "Workshop facilitator was successfully created." }
        format.json { render :show, status: :created, location: @workshop_facilitator }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @workshop_facilitator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workshop_facilitators/1 or /workshop_facilitators/1.json
  def update
    respond_to do |format|
      if @workshop_facilitator.update(workshop_facilitator_params)
        format.html { redirect_to @workshop_facilitator, notice: "Workshop facilitator was successfully updated." }
        format.json { render :show, status: :ok, location: @workshop_facilitator }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @workshop_facilitator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workshop_facilitators/1 or /workshop_facilitators/1.json
  def destroy
    @workshop_facilitator.destroy!

    respond_to do |format|
      format.html { redirect_to workshop_facilitators_path, status: :see_other, notice: "Workshop facilitator was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workshop_facilitator
      @workshop_facilitator = WorkshopFacilitator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def workshop_facilitator_params
      params.fetch(:workshop_facilitator, {})
    end
end
