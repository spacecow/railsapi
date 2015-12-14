module Api
  module V1
    class TaggingsController < ApplicationController

      def create
        tagging = repo.create_tagging(
          tagable_type:remove_tagable_type,
          tagable_id:remove_tagable_id,
          params:tagging_params)
        render json:{tagging:tagging.full_json}
      end

      def delete_all
        taggings = repo.delete_taggings
        render json:{taggings:taggings}
      end

      private

        def tagging_params
          params.require(:tagging).permit(:tag_id) 
        end

        def remove_tagable_id
          params.require(:tagging).delete(:tagable_id)
        end

        def remove_tagable_type
          params.require(:tagging).delete(:tagable_type)
        end

    end
  end
end
