describe "ParicipationsController" do

  let(:controller){ Api::V1::ParticipationsController.new }
  let(:repo){ double :repo }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/v1/participations_controller'
    allow(controller).to receive(:repo).with(no_args){ repo }
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    before do
      expect(controller).to receive(:participation_params).
        with(no_args){ :params }
      expect(repo).to receive(:create_participation).
        with(:params){ :participation } 
      expect(controller).to receive(:render).
        with(json:{participation: :participation}){ :render }
    end
    it{ should be :render }
  end

  describe "#delete_all" do
    let(:function){ :delete_all }
    before do
      expect(controller).to receive(:render).
        with(json:{participations: :participations}){ :render }
      expect(repo).to receive(:delete_participations).
        with(no_args){ :participations }
    end
    it{ subject }
  end

end
