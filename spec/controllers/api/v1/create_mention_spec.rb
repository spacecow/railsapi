describe "MentionsController#create" do

  let(:controller){ Api::V1::MentionsController.new }
  let(:repo){ double :repo }

  before do
    require './spec/controller_helper'
    require './app/controllers/api/v1/mentions_controller'
  end

  subject{ controller.create }

  before do
    expect(controller).to receive(:repo){ repo }
    expect(controller).to receive(:mention_params){ :params }
    expect(repo).to receive(:create_mention).with(:params){ :mention }
    expect(controller).to receive(:render).with({json:{mention: :mention}}){ :json }
  end
  it{ is_expected.to be :json }

end
