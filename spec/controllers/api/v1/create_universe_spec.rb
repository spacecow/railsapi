describe "UniversesController#create" do
  
  let(:controller){ Api::V1::UniversesController.new }
  let(:repo){ double :repo }

  before do
    require './spec/controller_helper'
    require './app/controllers/api/v1/universes_controller'
  end

  context "response" do
    subject{ controller.create } 
    before do
      expect(controller).to receive(:repo){ repo }
      expect(controller).to receive(:universe_params){ :params }
      expect(repo).to receive(:create_universe).with(:params){ :universe }
      expect(controller).to receive(:render).
        with({json:{universe: :universe}}){ :json }
    end
    it{ is_expected.to be :json }
  end

end
