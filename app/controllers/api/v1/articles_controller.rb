module Api
  module V1
    class ArticlesController < ApplicationController
    
      def index
        articles = repo.articles
        render json:{articles:articles}
      end

      def create
        article = repo.create_article universe_id, article_params
        render json:{article:article} 
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
