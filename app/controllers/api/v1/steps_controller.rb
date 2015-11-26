module Api
  module V1
    class StepsController < ApplicationController

      def delete_all
        steps = repo.delete_steps
        render json:{steps:steps}
      end

    end
  end
end
