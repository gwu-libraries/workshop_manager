class WorkshopFacilitatorsController < ApplicationController
  before_action :set_workshop_facilitator, only: %i[show edit update destroy]
  # before_action :require_login,
  #               only: %i[index show new edit create update destroy]

  # GET /workshop_facilitators
  def index
    @workshop_facilitators = WorkshopFacilitator.all
  end

  # GET /workshop_facilitators/1
  def show
  end

  # GET /workshop_facilitators/new
  def new
    @workshop_facilitator = WorkshopFacilitator.new
  end

  # GET /workshop_facilitators/1/edit
  def edit
  end

  # POST /workshop_facilitators
  def create
    @workshop_facilitator = WorkshopFacilitator.new(workshop_facilitator_params)

    respond_to do |format|
      if @workshop_facilitator.save
        format.html do
          redirect_to @workshop_facilitator,
                      notice: 'Workshop facilitator was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workshop_facilitators/1
  def update
    respond_to do |format|
      if @workshop_facilitator.update(workshop_facilitator_params)
        format.html do
          redirect_to @workshop_facilitator,
                      notice: 'Workshop facilitator was successfully updated.'
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workshop_facilitators/1
  def destroy
    @workshop_facilitator.destroy!

    respond_to do |format|
      format.html do
        redirect_to workshop_facilitators_path,
                    status: :see_other,
                    notice: 'Workshop facilitator was successfully destroyed.'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_workshop_facilitator
    @workshop_facilitator = WorkshopFacilitator.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def workshop_facilitator_params
    params.require(:workshop_facilitator).permit(:workshop_id, :facilitator_id)
  end
end
