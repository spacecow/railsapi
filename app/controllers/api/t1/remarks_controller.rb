module Api
  module T1
    class RemarksController < ApplicationController

      def create
        remark = factory.create_remark params[:remark]
        render json:{remark:remark.full_json}
      end

    end
  end
end
