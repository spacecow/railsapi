describe "TagsController#index" do

  let(:controller){ Api::V1::TagsController.new }
  let(:repo){ double :repo }

  before do
    require 'controller_helper'
    require './app/controllers/api/v1/tags_controller'
  end

  describe "response" do
    subject{ controller.index }
    before do
      expect(controller).to receive(:repo){ repo }
      expect(controller).to receive(:params){{universe_id: :universe_id}}
      expect(repo).to receive(:tags).with(:universe_id){ [:tag] }
      expect(controller).to receive(:render).with(
        {json:{tags:[:tag]}}){ :json }
    end
    it{ is_expected.to be :json }
  end

end
