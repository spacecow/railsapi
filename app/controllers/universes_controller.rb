class UniversesController < ApplicationController

  def index
    universes = repo.all_universes
    respond_to do |f|
      f.json{ render json:universes }
    end
  end

  def create
    universe = repo.create_universe universe_params
    respond_to do |f|
      f.json{ render json:universe }
    end
  end

  private

    def universe_params
      params.permit(:title) 
    end

end
