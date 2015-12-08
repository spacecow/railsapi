module Api
  module T1
    class EventsController < ApplicationController
  
      def create
        event = FactoryGirl.create :event, params[:event]
        render json:{event:event.factory_json}
      end

    end
  end
end
