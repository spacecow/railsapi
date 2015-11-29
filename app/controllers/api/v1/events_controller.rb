module Api
  module V1
    class EventsController < ApplicationController

      def show
        event = repo.event params[:id]
        json = repo.event_as_json(event)
        render json:{event:json}
      end

      def index
        events = repo.events params[:universe_id]
        render json:{events:events}
      end

      def create
        event = repo.create_event remove_universe_id, event_params
        render json:{event:event} 
      end

      def destroy
        event = repo.event(params[:id]).delete
        json = repo.event_as_json(event)
        render json:{event:json}
      end

      def delete_all
        events = repo.delete_events
        render json:{events:events}
      end

      private

        def event_params
          params.require(:event).permit(:title, :parent_tokens, :child_tokens)
        end

        def remove_universe_id
          params.require(:event).delete(:universe_id)
        end

    end
  end
end
