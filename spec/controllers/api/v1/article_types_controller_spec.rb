describe "ArticleTypesController" do

  let(:controller){ Api::V1::ArticleTypesController.new }
  let(:repo){ double :repo }

  before do
    stub_const "ApplicationController", Class.new unless defined?(Rails)
    require './app/controllers/api/v1/article_types_controller'
    expect(controller).to receive(:repo).with(no_args){ repo }
  end

  subject{ controller.send function }

  describe "#index" do
    let(:function){ :index }
    before do
      expect(repo).to receive(:article_types).with(no_args){ :article_types }
      expect(controller).to receive(:render).
        with(json:{article_types: :article_types}){ :render }
    end
    it{ should be :render }
  end

end
