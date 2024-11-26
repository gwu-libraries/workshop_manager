class TracksController < ApplicationController
  before_action :set_track, only: %i[show edit update destroy]
  # before_action :require_login, only: %i[new edit create update destroy]

  # GET /tracks
  def index
    @tracks = Track.all
  end

  # GET /tracks/1
  def show
  end

  # GET /tracks/new
  def new
    @track = Track.new
  end

  # GET /tracks/1/edit
  def edit
  end

  # POST /tracks
  def create
    @track = Track.new(track_params)

    respond_to do |format|
      if @track.save
        format.html do
          redirect_to @track, notice: 'Track was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tracks/1
  def update
    respond_to do |format|
      if @track.update(track_params)
        format.html do
          redirect_to @track, notice: 'Track was successfully updated.'
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  def destroy
    @track.destroy!

    respond_to do |format|
      format.html do
        redirect_to tracks_path,
                    status: :see_other,
                    notice: 'Track was successfully destroyed.'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_track
    @track = Track.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def track_params
    params.require(:track).permit(:title, :description, workshop_ids: [])
  end
end
