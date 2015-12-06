module Api
  module V1
    class RemarksController < ApplicationController

      def create
        event = repo.event params[:event_id]
        remark = repo.create_remark remark_params(event)
        render json:{remark:remark.full_json}
      end

      def delete_all
        remarks = repo.delete_remarks
        render json:{remarks:remarks.map(&:full_json)}
      end

      private

        def remark_params event 
          remarkable_id = event.remarkable_id.nil? ?
            event.create_remarkable.id.tap{ event.save } : 
            event.remarkable_id
          params.require(:remark).permit(:content).
            merge(remarkable_id:remarkable_id)
        end

    end
  end
end
