describe "BooksController#index" do

  let(:controller){ Api::V1::BooksController.new }
  let(:repo){ double :repo }

  before do
    require 'controller_helper'
    require './app/controllers/api/v1/books_controller'
  end

  describe "response" do
    subject{ controller.index }
    before do
      expect(controller).to receive(:repo){ repo }
      expect(controller).to receive(:universe_id){ :universe_id }
      expect(repo).to receive(:books).with(:universe_id){ :books }
      expect(controller).to receive(:render).with(
        {json:{books: :books}}){ :json }
    end
    it{ is_expected.to be :json }
  end
 
end
