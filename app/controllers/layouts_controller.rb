class LayoutsController < ApplicationController
  before_action :set_layout, only: [:new_strategy, :show_strategy, :new_point]

  def show_strategy
    @strategy = Strategy.find(params[:strategy_id])
  end

  def new_strategy
    @strategy = @layout.add_strategy(current_user)
    redirect_to layout_track_path(id: @track.id, layout_id:  @layout.id, strategy_id: @strategy.id)
  end

  def save_points
    @strategy = Strategy.find(params['strategy'])
    @strategy.save_points(params['notes'])
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
