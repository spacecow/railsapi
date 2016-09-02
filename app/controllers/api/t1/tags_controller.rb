module Api
  module T1
    class TagsController < ApplicationController
    
      def create
        tag = factory.create_tag tag_params 
        render json:{tag:tag.factory_json}
      end

      def delete_all
        tags = factory.delete_tags
        render json:{tags:tags.map(&:factory_json)}
      end

      private

        def tag_params
          (params[:tag] || ActionController::Parameters.new()).
            permit(:tagable_type, :tagable_id, :title, :universe_id).symbolize_keys
        end

    end
  end
end
