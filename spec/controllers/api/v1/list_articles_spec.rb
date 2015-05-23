describe "ArticlesController#index" do

  let(:controller){ Api::V1::ArticlesController.new }
  let(:repo){ double :repo }
  let(:params){ {universe_id: :universe_id} }

  before do
require 'controller_helper'
require './app/controllers/api/v1/articles_controller'
  end

  context "response" do
    subject{ controller.index } 
    before do
      expect(controller).to receive(:params){ params }
      expect(controller).to receive(:repo){ repo }
      expect(repo).to receive(:articles).with(:universe_id){ :articles }
      expect(controller).to receive(:render).
        with({json:{articles: :articles}}){ :json }
    end
    it{ is_expected.to be :json }
  end

end
