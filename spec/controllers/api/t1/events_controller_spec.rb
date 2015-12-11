describe "Api::T1::EventsController" do

  let(:controller){ Api::T1::EventsController.new }
  let(:factory){ double :factory }

  before do
    class ApplicationController; end unless defined?(Rails)
    class FactoryGirl; end unless defined?(Rails)
    require './app/controllers/api/t1/events_controller'
    allow(controller).to receive(:params).with(no_args){ params }
    expect(controller).to receive(:factory).with(no_args){ factory }
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    let(:params){{ event: :params }}
    let(:event){ double :remark }
    before do
      expect(factory).to receive(:create_event).with(:params){ event } 
      expect(event).to receive(:factory_json).with(no_args){ :json }
      expect(controller).to receive(:render).
        with(json:{event: :json}){ :render }
    end
    it{ should be :render }
  end

  describe "#delete_all" do
    let(:function){ :delete_all }
    before do
      expect(factory).to receive(:delete_events).with(no_args){ 1 }
      expect(controller).to receive(:render).with(json:{events:1}){ :render }
    end
    it{ should be :render }
  end

end
