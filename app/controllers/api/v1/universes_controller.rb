module Api
  module V1
    class UniversesController < ApplicationController
      before_action :doorkeeper_authorize! unless Rails.env.test?

      def index
        universes = repo.universes
        render json:{universes:universes}
      end

      def create
        universe = repo.create_universe universe_params
        render json:{universe:universe}
      end

      def delete_all
        universes = repo.delete_universes
        render json:{universes:universes}
      end

      private

        def universe_params
          params.require(:universe).permit(:title) 
        end

    end
  end
end
