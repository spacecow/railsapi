module Api
  module V1
    class MentionsController < ApplicationController

      def create
        mention = repo.create_mention mention_params
        render json:{mention:mention}
      end
      
      private
        
        def mention_params
          params.require(:mention).permit(:note_id, :image_data)
        end

    end
  end
end
