class UniversesController < ApplicationController

  def index
    universes = repo.all_universes
    render json:universes
  end

  def create
    universe = repo.create_universe universe_params
    render json:universe
  end

  private

    def universe_params
      params.permit(:title) 
    end

end
