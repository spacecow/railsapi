module Api
  module T1
    class ArticleNotesController < ApplicationController

      def create
        article_note = factory.create_article_note article_note_params
        render json:{article_note:article_note.factory_json}
      end

      def delete_all
        article_notes = factory.delete_article_notes
        render json:{article_notes:article_notes.map(&:factory_json)}
      end

      private

        def article_note_params
          (params[:article_note] || ActionController::Parameters.new()).
            permit(:article_id, :note_id) 
        end

    end
  end
end
