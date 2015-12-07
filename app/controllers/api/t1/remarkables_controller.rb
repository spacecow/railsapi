module Api
  module T1
    class RemarkablesController < ApplicationController
  
      def create
        remarkable = FactoryGirl.create :remarkable 
        render json:{remarkable:remarkable.full_json}
      end

    end
  end
end
