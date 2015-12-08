module Api
  module V1
    class UniversesController < ApplicationController
      #before_action :doorkeeper_authorize! unless Rails.env.test?

      def show
        universe = repo.universe params[:id]
        json = repo.universe_as_json(universe)
        render json:{universe:json}
      end

      def index
        universes = repo.universes
        render json:{universes:universes}
      end

      def create
        universe = repo.create_universe universe_params
        render json:{universe:universe}
      end

      private

        def universe_params
          params.require(:universe).permit(:title) 
        end

    end
  end
end
