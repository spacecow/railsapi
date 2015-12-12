module Api
  module T1
    class EventsController < ApplicationController
  
      def create
        event = factory.create_event event_params
        render json:{event:event.factory_json}
      end

      def delete_all
        events = factory.delete_events
        render json:{events:events}
      end

      private

        def event_params
          #TODO remove remarkable_id
          (params[:event] || ActionController::Parameters.new()).
            permit(:title, :universe_id, :remarkable_id) 
        end

    end
  end
end
