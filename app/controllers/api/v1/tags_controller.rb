module Api
  module V1
    class TagsController < ApplicationController

      def index
        tags = repo.tags
        render json:{tags:tags}
      end

      def create
        tag = repo.create_tag(params:tag_params)
        render json:{tag:tag} 
      end
  
      def delete_all
        tags = repo.delete_tags
        render json:{tags:tags}
      end
  
      private

        def tag_params
          params.require(:tag).permit(:title)
        end

    end
  end
end
