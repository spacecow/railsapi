class UniversesController < ApplicationController

  #TODO add universe as wrapper

  def index
    universes = repo.universes
    render json:universes
  end

  #TODO contoller specs for create
  def create
    universe = repo.create_universe universe_params
    render json:universe
  end

  #TODO contoller specs for delete_all
  def delete_all
    universes = repo.delete_universes
    render json:universes
  end

  private

    #TDOD add universe_params test
    def universe_params
      params.permit(:title) 
    end

end
