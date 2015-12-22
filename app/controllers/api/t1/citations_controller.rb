module Api
  module T1
    class CitationsController < ApplicationController
    
      def create
        citation = factory.create_citation citation_params 
        render json:{citation:citation.factory_json}
      end

      private

        def citation_params
          (params[:citation] || ActionController::Parameters.new()).
            permit(:content)
        end

    end
  end
end
