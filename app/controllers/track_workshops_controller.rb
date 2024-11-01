class TrackWorkshopsController < ApplicationController
  before_action :set_track_workshop, only: %i[ show edit update destroy ]

  # GET /track_workshops or /track_workshops.json
  def index
    @track_workshops = TrackWorkshop.all
  end

  # GET /track_workshops/1 or /track_workshops/1.json
  def show
  end

  # GET /track_workshops/new
  def new
    @track_workshop = TrackWorkshop.new
  end

  # GET /track_workshops/1/edit
  def edit
  end

  # POST /track_workshops or /track_workshops.json
  def create
    @track_workshop = TrackWorkshop.new(track_workshop_params)

    respond_to do |format|
      if @track_workshop.save
        format.html { redirect_to @track_workshop, notice: "Track workshop was successfully created." }
        format.json { render :show, status: :created, location: @track_workshop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @track_workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /track_workshops/1 or /track_workshops/1.json
  def update
    respond_to do |format|
      if @track_workshop.update(track_workshop_params)
        format.html { redirect_to @track_workshop, notice: "Track workshop was successfully updated." }
        format.json { render :show, status: :ok, location: @track_workshop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @track_workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /track_workshops/1 or /track_workshops/1.json
  def destroy
    @track_workshop.destroy!

    respond_to do |format|
      format.html { redirect_to track_workshops_path, status: :see_other, notice: "Track workshop was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track_workshop
      @track_workshop = TrackWorkshop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def track_workshop_params
      params.fetch(:track_workshop, {})
    end
end
