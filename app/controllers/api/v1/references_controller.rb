module Api
  module V1
    class ReferencesController < ApplicationController

      def show
        reference = repo.reference id:params[:id]
        render json:{reference:reference}
      end

      def create
        reference = repo.create_reference reference_params
        render json:{reference:reference}
      end
      
      def delete_all
        references = repo.references.map(&:to_json)
        repo.delete_references
        render json:{references:references}
      end

      private
        
        def reference_params
          params.
            require(:reference).
            permit(:note_id, :image_data, :url)
        end

    end
  end
end
