module Api
  module V1
    class ArticlesController < ApplicationController
    
      def create
        article = repo.create_article universe_id, article_params
        render json:{article:article} 
      end

      def delete_all
        articles = repo.delete_articles
        render json:{articles:articles}
      end

      private

        def article_params
          params.require(:article).permit(:name) 
        end
      
        def universe_id
          params.require(:article)["universe_id"]
        end

    end
  end
end
