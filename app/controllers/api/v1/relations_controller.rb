module Api
  module V1
    class RelationsController < ApplicationController

      def show
        relation = repo.relation params[:id]
        render json:{relation:relation.full_json}
      end

      def create
        relation = repo.create_relation relation_params
        render json:{relation:relation.full_json}
      end

      def delete_all
        relations = repo.delete_relations
        render json:{relations:relations.map(&:full_json)}
      end

      private

        def relation_params
          params.require(:relation).
            tap{|e| e[:type]=e[:type].camelcase}.
            permit(:origin_id, :target_id, :type)
        end

    end
  end
end
