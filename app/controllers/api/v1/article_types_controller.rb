module Api
  module V1
    class ArticleTypesController < ApplicationController

      def index
        article_types = repo.article_types
        render json:{article_types:article_types}
      end

    end
  end
end
