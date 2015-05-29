describe "BooksController#index" do

  let(:controller){ Api::V1::BooksController.new }
  let(:params){ double :params }
  let(:book_params){ double :book_params }
  let(:permitted_params){ %i(title) }

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

  describe "#book_params" do
    subject{ controller.send :book_params }
    before do
      expect(controller).to receive(:params){ params }
      expect(params).to receive(:require).with(:book){ book_params }
      expect(book_params).to receive(:permit).
        with(*permitted_params){ :params }
    end
    it{ is_expected.to be :params }
  end

  describe "#remove_universe_id" do
    subject{ controller.send :remove_universe_id }
    before do
      expect(controller).to receive(:params){ params }
      expect(params).to receive(:require).
        with(:book){ {universe_id: :id} }
    end
    it{ is_expected.to be :id }
  end

end
