module Api
  module T1
    class RemarksController < ApplicationController

      def create
        remark = FactoryGirl.create :remark, params[:remark]
        render json:{remark:remark.full_json}
      end

    end
  end
end
