module Api
  module V1
    class ArticlesController < ApplicationController
    
      def show
        article = repo.article id:params[:id]
        render json:{article:article}
      end

      def create
        article = repo.create_article remove_universe_id, article_params
        render json:{article:article} 
      end

      def delete_all
        articles = repo.delete_articles
        render json:{articles:articles}
      end

      private

        def article_params
          params.require(:article).permit(:name, :type) 
        end
      
        def remove_universe_id
          params.require(:article).delete(:universe_id)
        end

    end
  end
end
