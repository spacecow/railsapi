describe "ParicipationsController" do

  let(:controller){ Api::V1::ParticipationsController.new }
  let(:repo){ double :repo }

  before do
    module Api; module V1; class ApplicationController
    end end end unless defined?(Rails)
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
      expect(controller).to receive(:render).with(json:{participation: :participation}){ :render }
    end
    it{ subject }
  end

end
