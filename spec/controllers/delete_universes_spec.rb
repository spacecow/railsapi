describe "UniversesController#delete_all" do

  let(:controller){ UniversesController.new }
  let(:repo){ double :repo }

  before do
    require './spec/controller_helper'
    require './app/controllers/universes_controller'
  end

  context "response" do
    subject{ controller.delete_all }
    before do
      expect(controller).to receive(:repo){ repo }
      expect(repo).to receive(:delete_universes){ :universes }
      expect(controller).to receive(:render).
        with({json:{universes: :universes}}){ :json }
    end
    it{ is_expected.to be :json }
  end

end
