describe "StepsController" do

  let(:controller){ Api::V1::StepsController.new }
  let(:repo){ double :repo }

  before do
    stub_const "ApplicationController", Class.new unless defined?(Rails)
    require './app/controllers/api/v1/steps_controller'
    allow(controller).to receive(:repo).with(no_args){ repo }
    allow(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    let(:params){{ }}
    before do
      expect(controller).to receive(:step_params).with(no_args){ :params }
      expect(repo).to receive(:create_step).with(:params){ :step }
      expect(controller).to receive(:render).with(json:{step: :step}){ :render }
    end
    it{ should be :render }
  end

  describe "#delete_all" do
    let(:function){ :delete_all }
    before do
      expect(controller).to receive(:render).with(json:{steps: :steps}){ :render }
      expect(repo).to receive(:delete_steps).with(no_args){ :steps }
    end
    it{ should be :render }
  end

end
