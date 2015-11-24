module Api
  module V1
    class ParticipationsController < ApplicationController

      def create
        participation = repo.create_participation participation_params
        render json:{participation:participation}
      end

      def delete_all
        participations = repo.delete_participations
        render json:{participations:participations}
      end

      private

        def participation_params
          params.require(:participation).permit(:event_id, :article_id)
        end

    end
  end
end
