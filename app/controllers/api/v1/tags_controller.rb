module Api
  module V1
    class TagsController < ApplicationController

      def show
        tag = repo.tag params[:id]
        render json:{tag:tag}
      end

      def index
        tags = repo.tags
        render json:{tags:tags}
      end

      def create
        tag = repo.create_tag(params:tag_params)
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

    end
  end
end
