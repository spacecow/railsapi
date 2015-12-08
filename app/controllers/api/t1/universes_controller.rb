module Api
  module T1
    class UniversesController < ApplicationController
    
      def delete_all
        universes = factory.delete_universes
        render json:{universes:universes.map(&:factory_json)}
      end

    end
  end
end
