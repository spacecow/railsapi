module Api
  module T1
    class NotesController < ApplicationController

      def create
        note = factory.create_note note_params 
        render json:{note:note.factory_json}
      end

      private

        def note_params
          (params[:note] || ActionController::Parameters.new()).
            permit(:text) 
        end

    end
  end
end
