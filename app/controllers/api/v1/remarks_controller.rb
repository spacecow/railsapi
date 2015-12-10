module Api
  module V1
    class RemarksController < ApplicationController

      def show
        remark = repo.remark params[:id]
        render json:{remark:remark.full_json}
      end

      def create
        event = repo.event params[:event_id]
        remark = repo.create_remark remark_params(event)
        render json:{remark:remark.full_json}
      end

      def update
        remark = repo.remark params[:id]
        repo.update_remark remark, remark_params 
        render json:{remark:remark.full_json}
      end

      def destroy
        remark = repo.remark(params[:id]).delete
        render json:{remark:remark.full_json}
      end

      #TODO move to t1
      def delete_all
        remarks = repo.delete_remarks
        render json:{remarks:remarks.map(&:full_json)}
      end

      private

        def remark_params event=nil 
          if event
            remarkable_id = event.remarkable_id.nil? ?
              event.create_remarkable.id.tap{ event.save } : 
              event.remarkable_id
            params.require(:remark).permit(:content).
              merge(remarkable_id:remarkable_id)
          else
            params.require(:remark).permit(:content)
          end
        end

    end
  end
end
