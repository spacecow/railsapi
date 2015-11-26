module Api
  module V1
    class StepsController < ApplicationController

      def create
        step = repo.create_step step_params
        render json:{step:step}
      end

      def delete_all
        steps = repo.delete_steps
        render json:{steps:steps}
      end

      private

        def step_params
          params.require(:step).permit(:parent_id, :child_id)
        end

    end
  end
end
