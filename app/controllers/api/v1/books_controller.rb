module Api
  module V1
    class BooksController < ApplicationController

      def index
        books = repo.books universe_id
        render json:{books:books}
      end

      def create
        book = repo.create_book remove_universe_id, book_params
        render json:{book:book}
      end
  
      def delete_all
        books = repo.delete_books
        render json:{books:books}
      end

      private

        def book_params
          params.require(:book).permit(:title) 
        end

        def remove_universe_id
          params.require(:book).delete(:universe_id)
        end

        def universe_id
          params["universe_id"]
        end

    end
  end
end
