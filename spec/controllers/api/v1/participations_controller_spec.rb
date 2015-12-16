describe "ParicipationsController" do

  let(:controller){ Api::V1::ParticipationsController.new }
  let(:repo){ double :repo }
  let(:participation){ double :participation }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/v1/participations_controller'
    expect(controller).to receive(:repo).with(no_args){ repo }
    allow(controller).to receive(:params).with(no_args){ params }
    expect(participation).to receive(:full_json).with(no_args){ :json }
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    before do
      expect(controller).to receive(:participation_params).with(no_args){ :params }
      expect(repo).to receive(:create_participation).with(:params){ participation } 
      expect(controller).to receive(:render).
        with(json:{participation: :json}){ :render }
    end
    it{ should be :render }
  end

  describe "#destroy" do
    let(:function){ :destroy }
    let(:params){{ id: :id }}
    before do
      expect(repo).to receive(:delete_participation).with(:id){ participation }
      expect(controller).to receive(:render).
        with(json:{participation: :json}){ :render }
    end
    it{ should be :render }
  end

  describe "#delete_all" do
    let(:function){ :delete_all }
    before do
      expect(controller).to receive(:render).
        with(json:{participations:[:json]}){ :render }
      expect(repo).to receive(:delete_participations).
        with(no_args){ [participation] }
    end
    it{ should be :render }
  end

end
