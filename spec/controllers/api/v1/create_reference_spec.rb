describe "ReferencesController#create" do

  let(:controller){ Api::V1::ReferencesController.new }
  let(:repo){ double :repo }

  before do
    require './spec/controller_helper'
    require './app/controllers/api/v1/references_controller'
  end

  subject{ controller.create }

  before do
    expect(controller).to receive(:repo){ repo }
    expect(controller).to receive(:reference_params){ :params }
    expect(repo).to receive(:create_reference).with(:params){ :reference }
    expect(controller).to receive(:render).with({json:{reference: :reference}}){ :json }
  end
  it{ is_expected.to be :json }

end
