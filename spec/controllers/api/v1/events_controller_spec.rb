describe "EventsController" do

  let(:controller){ Api::V1::EventsController.new }
  let(:repo){ double :repo }
  let(:event){ double :event }

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
      expect(repo).to receive(:event).with(:id){ event }
      expect(controller).to receive(:render).with(json:{event: :json}){ :render }
      expect(event).to receive(:full_json).with(no_args){ :json }
    end
    it{ should be :render }
  end

  describe "#index" do
    let(:function){ :index }
    let(:params){{ universe_id: :universe_id }}
    before do
      expect(repo).to receive(:events).with(:universe_id){ :events }
      expect(controller).to receive(:render).with(json:{events: :events}){ :render }
    end
    it{ should be :render }
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
    it{ should be :render }
  end

  describe "#update" do
    let(:function){ :update }
    let(:params){{ id: :id }}
    before do
      expect(repo).to receive(:event).with(:id){ event }
      expect(repo).to receive(:update_event).with(event,:params){ :event }
      expect(controller).to receive(:event_params).with(no_args){ :params }
      expect(controller).to receive(:render).with(json:{event: :json}){ :render }
      expect(event).to receive(:full_json).with(no_args){ :json }
    end
    it{ should be :render }
  end

  describe "#destroy" do
    let(:function){ :destroy }
    let(:params){{ id: :id }}
    before do
      expect(controller).to receive(:render).with(json:{event: :json}){ :render }
      expect(repo).to receive(:event).with(:id){ event }
      expect(repo).to receive(:event_as_json).with(:event){ :json }
      expect(event).to receive(:delete).with(no_args){ :event }
    end
    it{ should be :render }
  end

end
