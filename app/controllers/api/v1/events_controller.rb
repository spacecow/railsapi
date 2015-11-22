module Api
  module V1
    class EventsController < ApplicationController

      def show
        event = repo.event params[:id]
        render json:{event:event}
      end

      def create
        event = repo.create_event remove_universe_id, event_params
        render json:{event:event} 
      end

      def delete_all
        events = repo.delete_events
        render json:{events:events}
      end

      private

        def event_params
          params.require(:event).permit(:title, :parent_id)
        end

        def remove_universe_id
          params.require(:event).delete(:universe_id)
        end

    end
  end
end
