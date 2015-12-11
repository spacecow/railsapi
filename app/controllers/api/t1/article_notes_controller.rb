module Api
  module T1
    class ArticleNotesController < ApplicationController

      def create
        article_note = factory.create_article_note params[:article_note]
        render json:{article_note:article_note.factory_json}
      end

      def delete_all
        article_notes = factory.delete_article_notes
        render json:{article_notes:article_notes.map(&:factory_json)}
      end

    end
  end
end
