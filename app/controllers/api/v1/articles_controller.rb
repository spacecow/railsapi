module Api
  module V1
    class ArticlesController < ApplicationController
    
      def create
        article = repo.create_article article_params
        render json:{article:article} 
      end

      private

        def article_params
          params.require(:article).permit(:name) 
        end

    end
  end
end
