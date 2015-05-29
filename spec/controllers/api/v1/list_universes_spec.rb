describe 'UniversesController#index' do

  let(:controller){ Api::V1::UniversesController.new }
  let(:repo){ double :repo }

  before do
    require 'controller_helper'
    require './app/controllers/api/v1/universes_controller'
  end

  describe "response" do 
    subject{ controller.index }
    before do
      expect(controller).to receive(:repo){ repo }
      expect(repo).to receive(:universes){ :universes }
      expect(controller).to receive(:render).
        with({json:{universes: :universes}}){ :json }
    end
    it{ is_expected.to be :json }
  end

end
