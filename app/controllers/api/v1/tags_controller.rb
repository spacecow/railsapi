module Api
  module V1
    class TagsController < ApplicationController

      def show
        tag = repo.tag params[:id]
        render json:{tag:tag.full_json}
      end

      def index
        tags = repo.tags params[:universe_id]
        render json:{tags:tags}
      end

      def create
        tag = repo.create_tag(remove_universe_id, tag_params)
        render json:{tag:tag} 
      end
  
      def destroy
        repo.delete_tag params[:id], **params[:tag].symbolize_keys
        render nothing:true 
      end

      private

        def tag_params
          params.require(:tag).permit(:title)
        end

        def remove_universe_id
          params.require(:tag).delete(:universe_id)
        end

    end
  end
end
