describe "TaggingsController#delete_all" do

  let(:controller){ Api::V1::TaggingsController.new }
  let(:repo){ double :repo }
  let(:record){ :tagging }

  before do
    require './spec/controller_helper'
    require './app/controllers/api/v1/taggings_controller'
  end

  context "response" do
    subject{ controller.delete_all }
    before do
      expect(controller).to receive(:repo){ repo }
      expect(repo).to receive(:delete_taggings).with(no_args){ [record] }
      expect(controller).to receive(:render).with({json:{taggings:[:tagging]}}){ :json }
    end
    it{ is_expected.to be :json }
  end

end
