module Api
  module V1
    class RelationTypesController < ApplicationController

      def index
        relation_types = repo.relation_types
        render json:{relation_types:relation_types}
      end

    end
  end
end
