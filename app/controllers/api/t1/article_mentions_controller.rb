module Api
  module T1
    class ArticleMentionsController < ApplicationController

      def create
        article_mention = factory.create_article_mention article_mention_params 
        render json:{article_mention:article_mention.factory_json}
      end

      private

        def article_mention_params
          (params[:article_mention] || ActionController::Parameters.new()).
            permit(:origin_id,:target_id,:content)
        end

    end
  end
end
