module Api
  module T1
    class EventNotesController < ApplicationController

      def create
        event_note = factory.create_event_note event_note_params
        render json:{event_note:event_note.factory_json}
      end
      
      def delete_all
        event_notes = factory.delete_event_notes
        render json:{event_notes:event_notes.map(&:factory_json)}
      end

      private

        def event_note_params
          (params[:event_note] || ActionController::Parameters.new()).
            permit(:event_id, :note_id) 
        end
  
    end
  end
end
