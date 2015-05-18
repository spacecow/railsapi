describe "ArticlesController" do

  let(:controller){ Api::V1::ArticlesController.new }
  let(:params){ double :params }
  let(:article_params){ double :article_params }
  let(:permitted_params){ %i(name) }

  before do
    require './spec/controller_helper'
    require './app/controllers/api/v1/articles_controller'
  end

  describe "#article_params" do
    subject{ controller.send :article_params }
    before do
      expect(controller).to receive(:params){ params }
      expect(params).to receive(:require).
        with(:article){ article_params }
      expect(article_params).to receive(:permit).
        with(*permitted_params){ :params }
    end
    it{ is_expected.to be :params }
  end

end
