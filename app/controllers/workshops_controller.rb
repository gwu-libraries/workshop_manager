class WorkshopsController < ApplicationController
  before_action :set_workshop, only: %i[show edit update destroy]
  # before_action :require_login, only: %i[new edit create update destroy]

  # GET /workshops or /workshops.json
  def index
    @workshops = Workshop.all
  end

  # GET /workshops/1 or /workshops/1.json
  def show
  end

  # GET /workshops/new
  def new
    @workshop = Workshop.new
  end

  # GET /workshops/1/edit
  def edit
  end

  # POST /workshops or /workshops.json
  def create
    @workshop = Workshop.new(workshop_params)

    respond_to do |format|
      if @workshop.save
        format.html do
          redirect_to @workshop, notice: 'Workshop was successfully created.'
        end
        format.json { render :show, status: :created, location: @workshop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @workshop.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /workshops/1 or /workshops/1.json
  def update
    respond_to do |format|
      if @workshop.update(workshop_params)
        format.html do
          redirect_to @workshop, notice: 'Workshop was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @workshop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @workshop.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /workshops/1 or /workshops/1.json
  def destroy
    @workshop.destroy!

    respond_to do |format|
      format.html do
        redirect_to workshops_path,
                    status: :see_other,
                    notice: 'Workshop was successfully destroyed.'
      end
      format.json { head :no_content }
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
      :end_time
    )
  end
end
