module Api
  module V1
    class TagsController < ApplicationController

      def create
        tag = repo.create_tag(
          tagable_id:remove_tagable_id,
          tagable_type:remove_tagable_type,
          params:tag_params)
        render json:{tag:tag} 
      end
  
      def delete_all
        tags = repo.delete_tags
        render json:{tags:tags}
      end
        #references = repo.references.as_json
        #repo.delete_references
        #render json:{references:references}
  
      private

        def tag_params
          params.require(:tag).permit(:title)
        end

        def remove_tagable_id
          params.require(:tag).delete(:tagable_id)
        end

        def remove_tagable_type
          params.require(:tag).delete(:tagable_type)
        end

    end
  end
end
