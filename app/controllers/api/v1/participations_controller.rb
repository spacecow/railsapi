module Api
  module V1
    class ParticipationsController < ApplicationController

      def create
        participation = repo.create_participation participation_params
        render json:{participation:participation.full_json}
      end

      def destroy
        participation = repo.delete_participation params[:id]
        render json:{participation:participation.full_json}
      end

      private

        def participation_params
          params.require(:participation).permit(:event_id, :article_id)
        end

    end
  end
end
