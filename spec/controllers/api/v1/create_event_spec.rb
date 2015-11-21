describe "EventsController#create" do

  let(:controller){ Api::V1::EventsController.new }
  let(:repo){ double :repo }

  before do
    stub_const "ApplicationController", Class.new unless defined?(Rails)
    require './app/controllers/api/v1/events_controller'
    allow(controller).to receive(:repo).with(no_args){ repo }
  end

  subject{ controller.create }

  before do
    expect(repo).to receive(:create_event).with(no_args){ :event }
  end

  describe "successful" do
    before do
      expect(controller).to receive(:render).
        with(json:{event: :event}){ :render }
    end
    it{ should eq :render }
  end

end
