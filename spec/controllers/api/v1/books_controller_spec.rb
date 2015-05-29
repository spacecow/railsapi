describe "BooksController#index" do

  let(:controller){ Api::V1::BooksController.new }

  before do
    require 'controller_helper'
    require './app/controllers/api/v1/books_controller'
  end

  describe "#universe_id" do
    subject{ controller.send :universe_id }
    before do
      expect(controller).to receive(:params){ {"universe_id" => :universe_id} }
    end
    it{ is_expected.to eq :universe_id }
  end

end
