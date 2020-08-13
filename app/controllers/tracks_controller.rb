class TracksController < ApplicationController
  before_action :set_track, only: [:show, :edit, :update, :destroy, :new_layout, :layout]

  # GET /tracks
  def index
    @pagy, @tracks = pagy(Track.sort_by_params(params[:sort], sort_direction))

    # We explicitly load the records to avoid triggering multiple DB calls in the views when checking if records exist and iterating over them.
    # Calling @tracks.any? in the view will use the loaded records to check existence instead of making an extra DB call.
    @tracks.load
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
    if @track.save
      redirect_to @track, notice: "Track was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /tracks/1
  def update
    if @track.update(track_params)
      redirect_to @track, notice: "Track was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /tracks/1
  def destroy
    @track.destroy
    redirect_to tracks_url, notice: "Track was successfully destroyed."
  end

  def new_layout
    @track.add_layout(params[:name],params[:image])
    redirect_to @track
  end

  def layout
    if params[:strategy_id].present?
      @strategy = Strategy.find(params[:strategy_id])
      @layout = @strategy.layout if @strategy
    else
      @layout = @track.layouts.find(params[:layout_id])
      @strategy = @layout.strategies.fisrt
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_track
    @track = Track.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def track_params
    params.require(:track).permit(:name, :location, :track_id, :layout_id, :strategy_id)
  end
end
