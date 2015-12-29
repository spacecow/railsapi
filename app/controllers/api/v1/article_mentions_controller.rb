module Api
  module V1
    class ArticleMentionsController < ApplicationController

      def create
        mention = repo.create_article_mention(
          origin_id:remove_origin_id,
          params: mention_params)
        render json:{article_mention:mention.full_json}
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
