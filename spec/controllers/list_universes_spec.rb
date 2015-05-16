describe "UniversesController" do

  let(:controller){ UniversesController.new }
  let(:repo){ double :repo }

  before do
    require './spec/controller_helper'
    require './app/controllers/universes_controller'
  end

  context "response" do 
    subject{ controller.index }
    before do
      expect(controller).to receive(:render).with({json: :universes}){ :json }
      expect(repo).to receive(:all_universes){ :universes }
      expect(controller).to receive(:repo){ repo }
    end
    it{ is_expected.to be :json }
  end

end
