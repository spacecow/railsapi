describe "EventsController" do

  let(:controller){ Api::V1::EventsController.new }
  let(:repo){ double :repo }

  before do
    stub_const "ApplicationController", Class.new unless defined?(Rails)
    require './app/controllers/api/v1/events_controller'
    allow(controller).to receive(:repo).with(no_args){ repo }
    allow(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    let(:params){{ id: :id }}
    before do
      expect(repo).to receive(:event).with(:id){ :event }
      expect(controller).to receive(:render).with(json:{event: :event}){ :render }
    end
    it{ should eq :render }
  end

  describe "#create" do
    let(:function){ :create }

    before do
      expect(controller).to receive(:remove_universe_id).
        with(no_args){ :universe_id }
      expect(controller).to receive(:event_params).
        with(no_args){ :params }
      expect(controller).to receive(:render).with(json:{event: :event}){ :render }
      expect(repo).to receive(:create_event).with(:universe_id, :params){ :event }
    end

    it{ should eq :render }
  end

end