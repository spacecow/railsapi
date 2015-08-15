module Api
  module V1
    class NotesController < ApplicationController

      def create
        p params
        note = repo.create_note(
          universe_id:remove_universe_id,
          article_id:remove_article_id)
        #book = repo.create_book remove_universe_id, book_params
        #render json:{book:book}
        render json:{note:note}
      end

      private

        def remove_article_id
          params.require(:note).delete(:article_id)
        end

        def remove_universe_id
          params.require(:note).delete(:universe_id)
        end
    
    end
  end
end
