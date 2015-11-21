module Api
  module V1
    class EventsController < ApplicationController

      def create
        #TODO attach universe id
        #TODO attach param
#article = repo.create_article remove_universe_id, article_params
        event = repo.create_event
        render json:{event:event} 
      end

    end
  end
end
