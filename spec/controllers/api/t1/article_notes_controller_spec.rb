require 'action_controller'

describe "Api::T1::ArticleNotesController" do

  let(:controller){ Api::T1::ArticleNotesController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/t1/article_notes_controller'
  end

  subject{ controller.send function }

  describe "REST" do

    let(:factory){ double :factory }
    let(:article_note){ double :article_note }

    before do
      expect(controller).to receive(:factory).with(no_args){ factory }
      expect(article_note).to receive(:factory_json).with(no_args){ :json }
    end

    describe "#create" do
      let(:function){ :create }
      before do
        expect(controller).to receive(:article_note_params).with(no_args){ :params }
        expect(controller).to receive(:render).
          with(json:{article_note: :json}){ :render }
        expect(factory).to receive(:create_article_note).
          with(:params){ article_note }
      end
      it{ should be :render }
    end

    describe "#delete_all" do
      let(:function){ :delete_all }
      let(:article_note){ double :article_note }
      before do
        expect(controller).to receive(:render).
          with(json:{article_notes:[:json]}){ :render }
        expect(factory).to receive(:delete_article_notes).
          with(no_args){ [article_note] }
      end
      it{ should be :render }
    end
  end

  describe "Private" do

    before{ expect(controller).to receive(:params).with(no_args){ params }}

    describe "#article_note_params" do
      let(:function){ :article_note_params }
      let(:params){ ActionController::Parameters.new(params_hash) }
    
      context "no params" do
        let(:params_hash){ {} } 
        it{ should eq({}) }
      end

      context "with params" do
        let(:params_hash){{ article_note:{
          article_id: :article_id, note_id: :note_id, xxx: :xxx }}} 
        it{ should eq({ "article_id" => :article_id, "note_id" => :note_id }) }
      end

    end
  end

end
