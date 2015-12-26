module Api
  module V1
    class CitationsController < ApplicationController

      def create
        citation = repo.create_citation citation_params
        render json:{citation:citation.full_json}
      end

      private

        def citation_params
          params.require(:citation).permit(:content,:origin_id,:target_id)
        end

    end
  end
end
