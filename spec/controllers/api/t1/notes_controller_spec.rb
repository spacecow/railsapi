require 'action_controller'

describe "Api::T1::NotesController" do

  let(:controller){ Api::T1::NotesController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/t1/notes_controller'
  end

  subject{ controller.send function }

  describe "REST" do

    let(:factory){ double :factory }
    let(:note){ double :note }

    before do
      expect(controller).to receive(:factory).with(no_args){ factory }
      expect(note).to receive(:factory_json).with(no_args){ :json }
    end

    describe "#create" do
      let(:function){ :create }
      before do
        expect(controller).to receive(:note_params).with(no_args){ :params }
        expect(factory).to receive(:create_note).with(:params){ note }
        expect(controller).to receive(:render).
          with(json:{note: :json}){ :render }
      end
      it{ should be :render }
    end
  end

  describe "Private" do

    before{ expect(controller).to receive(:params).with(no_args){ params }}

    describe "#note_params" do
      let(:function){ :note_params }
      let(:params){ ActionController::Parameters.new(params_hash) }
    
      context "no params" do
        let(:params_hash){ {} } 
        it{ should eq({}) }
      end

      context "with params" do
        let(:params_hash){{ note:{
          text: :text, xxx: :xxx }}} 
        it{ should eq({ "text" => :text }) }
      end

    end
  end

end
