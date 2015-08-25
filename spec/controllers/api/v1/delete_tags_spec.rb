describe "TagsController#delete_all" do

  let(:controller){ Api::V1::TagsController.new }
  let(:repo){ double :repo }
  let(:record){ :tag }

  before do
    require './spec/controller_helper'
    require './app/controllers/api/v1/tags_controller'
  end

  context "response" do
    subject{ controller.delete_all }
    before do
      expect(controller).to receive(:repo){ repo }
      expect(repo).to receive(:delete_tags).with(no_args){ [record] }
      expect(controller).to receive(:render).with({json:{tags:[:tag]}}){ :json }
    end
    it{ is_expected.to be :json }
  end

end
