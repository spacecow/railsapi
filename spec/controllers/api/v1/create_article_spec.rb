describe "ArticlesController#create" do

  let(:controller){ Api::V1::ArticlesController.new }
  let(:repo){ double :repo }

  before do
    require './spec/controller_helper'
    require './app/controllers/api/v1/articles_controller'
  end

  describe "response" do
    subject{ controller.create }
    before do
      expect(controller).to receive(:repo){ repo }
      expect(controller).to receive(:remove_universe_id){ :id }
      expect(controller).to receive(:article_params){ :params }
      expect(repo).to receive(:create_article).with(:id, :params){ :article }
      expect(controller).to receive(:render).
        with({json:{article: :article}}){ :json }
    end
    it{ is_expected.to be :json }
  end
 
end
