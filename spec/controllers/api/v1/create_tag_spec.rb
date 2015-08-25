describe "TagsController#create" do

  let(:controller){ Api::V1::TagsController.new }
  let(:repo){ double :repo }

  before do
    require './spec/controller_helper'
    require './app/controllers/api/v1/tags_controller'
  end

  describe "response" do
    before do
      expect(controller).to receive(:repo){ repo }
      expect(controller).to receive(:remove_tagable_id){ :id }
      expect(controller).to receive(:remove_tagable_type){ :type }
      expect(controller).to receive(:tag_params){ :params }
      expect(repo).to receive(:create_tag).with({
        tagable_id: :id,
        tagable_type: :type,
        params: :params }){ :tag }
      expect(controller).to receive(:render).with({json:{tag: :tag}}){ :json }
    end
    subject{ controller.create }
    it{ is_expected.to be :json }
  end
  
end
