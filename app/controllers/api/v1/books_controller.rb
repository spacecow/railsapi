module Api
  module V1
    class BooksController < ApplicationController

      def index
        books = repo.books universe_id
        render json:{books:books}
      end

      private

        def universe_id
          params["universe_id"]
        end

    end
  end
end
