require 'action_controller'

describe "Api::T1::EventNotesController" do

  let(:controller){ Api::T1::EventNotesController.new }
  let(:factory){ double :factory }
  let(:event_note){ double :event_note }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/t1/event_notes_controller'
  end
  
  subject{ controller.send function }

  describe "REST" do

    before{ expect(controller).to receive(:factory).with(no_args){ factory }}

    describe "#create" do
      let(:function){ :create }
      before do
        expect(controller).to receive(:event_note_params).with(no_args){ :params }
        expect(factory).to receive(:create_event_note).with(:params){ event_note }
        expect(event_note).to receive(:factory_json).with(no_args){ :json }
        expect(controller).to receive(:render).
          with(json:{event_note: :json}){ :render }
      end
      it{ should be :render }
    end
  end

  describe "Private" do

    before{ expect(controller).to receive(:params).with(no_args){ params }}

    describe "#event_note_params" do
      let(:function){ :event_note_params }
      let(:params){ ActionController::Parameters.new(params_hash) }
    
      context "no params" do
        let(:params_hash){ {} } 
        it{ should eq({}) }
      end

      context "with params" do
        let(:params_hash){{ event_note:{
          event_id: :event_id, note_id: :note_id, xxx: :xxx }}} 
        it{ should eq({ "event_id" => :event_id, "note_id" => :note_id }) }
      end

    end
  end

end
