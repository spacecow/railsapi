module Api
  module V1
    class NotesController < ApplicationController

      def show
        note = repo.note params[:id]
        json = repo.note_as_json(note)
        render json:{note:json}
      end

      def create
        note = repo.create_note(article_id:remove_article_id, params:note_params)
        render json:{note:note}
      end

      def update
        note = repo.note params[:id]
        repo.update_note note, note_params 
        json = repo.note_as_json(note)
        render json:{note:json}
      end

      def destroy
        note = repo.note(params[:id]).delete
        json = repo.note_as_json(note)
        render json:{note:json}
      end

      def delete_all
        notes = repo.delete_notes
        render json:{notes:notes}
      end

      private

        def note_params
          params.require(:note).permit(:text) 
        end
      
        def remove_article_id
          params.require(:note).delete(:article_id)
        end

    end
  end
end
