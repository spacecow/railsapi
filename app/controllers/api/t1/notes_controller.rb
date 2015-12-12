module Api
  module T1
    class NotesController < ApplicationController

      def create
        note = factory.create_note params[:note]
        render json:{note:note.factory_json}
      end

    end
  end
end
