class StrategiesController < ApplicationController
  respond_to :html

  before_action :authenticate_user!
  before_action :set_layout, only: [:new_strategy, :show_strategy, :new_point]

  def show_strategy
    @strategy = Strategy.find(params[:strategy_id])
  end

  def new_strategy
    @strategy = @layout.add_strategy(current_user)
    redirect_to show_layout_track_path(id: @track.id, layout_id: @layout.id, strategy_id: @strategy.id, edit: true)
  end

  def save_points
    raise "Informe a estrategia" unless params["strategy"].present?
    @strategy = Strategy.find(params["strategy"])
    @strategy.save_points(params["notes"])
    render json: @strategy.points.all
  rescue => e
    puts e.message
  end

  def load_points
    raise "Informe a estrategia" unless params["strategy"].present?
    @strategy = Strategy.find(params["strategy"])
    notes = @strategy.image_notes
    render json: notes
  rescue => e
    puts e.message
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_layout
    @layout = Layout.find(params[:id])
    @track = @layout.track
  end
end
