describe 'BooksController#delete_all' do

  let(:controller){ Api::V1::BooksController.new }
  let(:repo){ double :repo }
  
  before do
    require './spec/controller_helper'
    require './app/controllers/api/v1/books_controller'
  end

  context 'response' do
    before do
      expect(controller).to receive(:repo){ repo } 
      expect(repo).to receive(:delete_books){ :books }
      expect(controller).to receive(:render).
        with({json:{books: :books}}){ :json }
    end
    subject{ controller.delete_all }
    it{ is_expected.to be :json }
  end

end
