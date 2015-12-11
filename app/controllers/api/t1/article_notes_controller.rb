module Api
  module T1
    class ArticleNotesController < ApplicationController

      def delete_all
        article_notes = factory.delete_article_notes
        render json:{article_notes:article_notes.map(&:full_json)}
      end

    end
  end
end
