describe "ArticlesController" do

  #TODO add create & delete

  let(:controller){ Api::V1::ArticlesController.new }
  let(:article_params){ double :article_params }
  let(:permitted_params){ %i(name type gender) }
  let(:repo){ double :repo }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/v1/articles_controller'
    allow(controller).to receive(:params).with(no_args){ params }
    allow(controller).to receive(:repo).with(no_args){ repo }
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    let(:params){{ id: :id }}
    before do
      expect(repo).to receive(:article).with(:id){ :article }
      expect(repo).to receive(:article_as_json).with(:article){ :json }
      expect(controller).to receive(:render).
        with(json:{article: :json}){ :render }
    end
    it{ should be :render }
  end

  describe "#index" do
    let(:function){ :index }
    let(:params){{ universe_id: :universe_id }}
    before do
      expect(repo).to receive(:articles).
        with(universe_id: :universe_id){ :articles }
      expect(repo).to receive(:articles_as_json).
        with(:articles){ :json }
      expect(controller).to receive(:render).
        with(json:{articles: :json}){ :render }
    end
    it{ should be :render }
  end

  describe "#create" do
    let(:function){ :create }
    before do
      expect(controller).to receive(:remove_universe_id).
        with(no_args){ :universe_id }
      expect(controller).to receive(:article_params).with(no_args){ :params }
      expect(controller).to receive(:render).with(json:{article: :json}){ :render }
      expect(repo).to receive(:create_article).
        with(:universe_id,:params){ :article }
      expect(repo).to receive(:article_as_json).with(:article){ :json }
    end
    it{ should be :render }
  end

  describe "#update" do
    let(:function){ :update }
    let(:params){{ id: :id }}
    before do
      expect(repo).to receive(:article).with(:id){ :article } 
      expect(repo).to receive(:update_article).with(:article,:params)
      expect(repo).to receive(:article_as_json).with(:article){ :json }
      expect(controller).to receive(:article_params).with(no_args){ :params }
      expect(controller).to receive(:render).
        with(json:{article: :json}){ :render }
    end
    it{ should be :render }
  end

  describe "#delete_all" do
    let(:function){ :delete_all }
    before do
      expect(controller).to receive(:render).
        with(json:{articles: :articles}){ :render }
      expect(repo).to receive(:delete_articles).with(no_args){ :articles }
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
