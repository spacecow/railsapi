module Api
  module T1
    class ParticipationsController < ApplicationController

      def create
        participation = factory.create_participation participation_params 
        render json:{participation:participation.factory_json}
      end

      private

        def participation_params
          (params[:participation] || ActionController::Parameters.new()).
            permit(:article_id,:event_id).symbolize_keys
        end

    end
  end
end
