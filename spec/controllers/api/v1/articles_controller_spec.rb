describe "ArticlesController" do

  #TODO add create & delete

  let(:controller){ Api::V1::ArticlesController.new }
  let(:article_params){ double :article_params }
  let(:permitted_params){ %i(name type) }
  let(:repo){ double :repo }

  before do
    #require './spec/controller_helper'
    module Api; module V1; class ApplicationController
    end end end
    require './app/controllers/api/v1/articles_controller'
    allow(controller).to receive(:params).with(no_args){ params }
    allow(controller).to receive(:repo).with(no_args){ repo }
  end

  subject{ controller.send function }

  describe "#index" do
    let(:function){ :index }
    let(:params){{ universe_id: :universe_id }}
    before do
      expect(repo).to receive(:articles).
        with(universe_id: :universe_id){ :articles }
      expect(controller).to receive(:render).
        with(json:{articles: :articles}){ :render }
    end
    it{ should be :render }
  end

  describe "#article_params" do
    let(:function){ :article_params }
    let(:params){ double :params }
    before do
      expect(controller).to receive(:params){ params }
      expect(params).to receive(:require).
        with(:article){ article_params }
      expect(article_params).to receive(:permit).
        with(*permitted_params){ :params }
    end
    it{ is_expected.to be :params }
  end

  describe "#remove_universe_id" do
    let(:function){ :remove_universe_id }
    let(:params){ double :params }
    before do
      expect(controller).to receive(:params){ params }
      expect(params).to receive(:require).
        with(:article){ {universe_id: :id} }
    end
    it{ is_expected.to be :id }
  end

end
