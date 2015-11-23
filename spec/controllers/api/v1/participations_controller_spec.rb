describe "ParicipationsController" do

  let(:controller){ Api::V1::ParticipationsController.new }
  let(:repo){ double :repo }

  before do
    module Api; module V1; class ApplicationController
      def repo; NotImplementedError.new end
    end end end unless defined?(Rails)
    require './app/controllers/api/v1/participations_controller'
    allow(controller).to receive(:repo).with(no_args){ repo }
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    before do
      expect(repo).to receive(:create_participation).
        with(no_args){ :participation } 
      expect(controller).to receive(:render).with(json:{participation:{}}){ :render }
    end
    it{ subject }
  end

end
