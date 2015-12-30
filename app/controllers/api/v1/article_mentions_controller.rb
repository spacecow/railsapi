module Api
  module V1
    class ArticleMentionsController < ApplicationController

      def create
        mdl = repo.create_article_mention(
          origin_id:remove_origin_id,
          params: mention_params)
        render json:{article_mention:mdl.full_json}
      end

      def update
        mdl = repo.update_article_mention params[:id], mention_params 
        render json:{article_mention:mdl.full_json}
      end

      private

        def remove_origin_id
          params.require(:article_mention).delete(:origin_id)
        end

        def mention_params
          params.require(:article_mention).permit(:target_id,:content)
        end

    end
  end
end
