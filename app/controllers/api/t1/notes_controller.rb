module Api
  module T1
    class NotesController < ApplicationController

      def index
        notes = factory.notes
        render json:{notes:notes.map(&:factory_json)}
      end

    end
  end
end
