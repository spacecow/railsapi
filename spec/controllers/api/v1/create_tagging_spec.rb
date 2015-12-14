describe "TaggingsController#create" do

  let(:controller){ Api::V1::TaggingsController.new }
  let(:repo){ double :repo }
  let(:tagging){ double :tagging }

  before do
    require './spec/controller_helper'
    require './app/controllers/api/v1/taggings_controller'
  end

  describe "response" do
    before do
      expect(controller).to receive(:repo){ repo }
      expect(controller).to receive(:remove_tagable_type){ :type }
      expect(controller).to receive(:remove_tagable_id){ :id }
      expect(controller).to receive(:tagging_params){ :params }
      expect(tagging).to receive(:full_json).with(no_args){ :json }
      expect(repo).to receive(:create_tagging).with(
        tagable_type: :type,
        tagable_id: :id,
        params: :params){ tagging }
      expect(controller).to receive(:render).with(
        {json:{tagging: :json}}){ :render }
    end
    subject{ controller.create }
    it{ should be :render }
  end

end
