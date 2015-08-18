module Api
  module V1
    class ReferencesController < ApplicationController

      def create
        reference = repo.create_reference reference_params
        render json:{reference:reference}
      end
      
      private
        
        def reference_params
          params.require(:reference).permit(:note_id, :image_data)
        end

    end
  end
end
