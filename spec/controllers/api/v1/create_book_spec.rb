describe "BooksController#create" do

  let(:controller){ Api::V1::BooksController.new }
  let(:repo){ double :repo }

  before do
    require 'controller_helper'
    require './app/controllers/api/v1/books_controller'
  end

  describe "response" do
    subject{ controller.create }
    before do
      expect(controller).to receive(:repo){ repo }
      expect(controller).to receive(:remove_universe_id){ :id }
      expect(controller).to receive(:book_params){ :params }
      expect(repo).to receive(:create_book).with(:id, :params){ :book }
      expect(controller).to receive(:render).
        with({json:{book: :book}}){ :json }
    end
    it{ is_expected.to eq :json }
  end

end
