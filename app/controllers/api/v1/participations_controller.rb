module Api
  module V1
    class ParticipationsController < ApplicationController

      def create
        repo.create_participation
        render json:{participation:{}}
      end

    end
  end
end
