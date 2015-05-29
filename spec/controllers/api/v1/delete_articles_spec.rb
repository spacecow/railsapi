describe 'ArticlesController#delete_all' do

  let(:controller){ Api::V1::ArticlesController.new }
  let(:repo){ double :repo }

  before do
    require './spec/controller_helper'
    require './app/controllers/api/v1/articles_controller'
  end

  context 'response' do
    before do
      expect(controller).to receive(:repo){ repo }
      expect(repo).to receive(:delete_articles){ :articles }
      expect(controller).to receive(:render).
        with({json:{articles: :articles}}){ :json }
    end
    subject{ controller.delete_all }
    it{ is_expected.to be :json }
  end

end
