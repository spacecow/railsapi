require 'action_controller'

describe "Api::T1::EventsController" do

  let(:controller){ Api::T1::EventsController.new }
  let(:factory){ double :factory }
  let(:event){ double :remark }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/t1/events_controller'
  end

  subject{ controller.send function }

  describe "REST" do

    before do
      allow(controller).to receive(:params).with(no_args){ params }
      expect(controller).to receive(:factory).with(no_args){ factory }
    end

    describe "#create" do
      let(:function){ :create }
      before do
        expect(controller).to receive(:event_params).with(no_args){ :params }
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

  describe "Private" do

    before{ expect(controller).to receive(:params).with(no_args){ params }}

    describe "#event_params" do
      let(:function){ :event_params }
      let(:params){ ActionController::Parameters.new(params_hash) }
    
      context "no params" do
        let(:params_hash){ {} } 
        it{ should eq({}) }
      end

      context "with params" do
        let(:params_hash){{ event:{
          title: :title, xxx: :xxx }}} 
        it{ should eq({ "title" => :title }) }
      end

    end
  end

end
