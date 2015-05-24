describe 'UniversesController#show' do

  let(:controller){ Api::V1::UniversesController.new }
  let(:repo){ double :repo }
  let(:params){ {id: :id} }

  before do
    require './spec/controller_helper'
    require './app/controllers/api/v1/universes_controller'
  end

  context "response" do 
    subject{ controller.show }
    before do
      expect(controller).to receive(:repo){ repo }
      expect(controller).to receive(:params){ params }
      expect(repo).to receive(:universe).with(:id){ :universe }
      expect(controller).to receive(:render).
        with(json:{universe: :universe}){ :json }
    end
    it{ is_expected.to eq :json }
  end

end
