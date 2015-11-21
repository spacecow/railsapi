module Api
  module V1
    class EventsController < ApplicationController

      def create
        #TODO attach param
#article = repo.create_article remove_universe_id, article_params
        event = repo.create_event remove_universe_id
        render json:{event:event} 
      end

      private

        def remove_universe_id
          params.require(:event).delete(:universe_id)
        end

    end
  end
end
