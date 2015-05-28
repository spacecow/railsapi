module Api
  module V1
    class ArticleTypesController < ApplicationController

      def index
        render json:{article_types:['Character']} 
      end

    end
  end
end
