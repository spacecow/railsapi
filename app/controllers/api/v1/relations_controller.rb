module Api
  module V1
    class RelationsController < ApplicationController

      def create
        relation = repo.create_relation relation_params
        render json:{relation:relation}
      end

      def delete_all
        relations = repo.delete_relations
        render json:{relations:relations}
      end

      private

        def relation_params
          params.require(:relation).permit(:origin_id, :target_id, :type)
        end

    end
  end
end