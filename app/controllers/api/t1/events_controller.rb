module Api
  module T1
    class EventsController < ApplicationController
  
      def create
        event = factory.create_event params[:event]
        render json:{event:event.factory_json}
      end

      def delete_all
        events = factory.delete_events
        render json:{events:events}
      end

    end
  end
end
