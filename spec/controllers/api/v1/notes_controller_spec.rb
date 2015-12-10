describe "NotesController" do

  let(:controller){ Api::V1::NotesController.new }
  let(:repo){ double :repo }
  
  before do
    class ApplicationController; end
    require './app/controllers/api/v1/notes_controller'
    expect(controller).to receive(:repo).with(no_args).at_least(1){ repo }
    expect(controller).to receive(:params).with(no_args).at_least(1){ params }
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    let(:params){{ id: :id }}
    before do
      expect(repo).to receive(:note).with(:id){ :note }
      expect(repo).to receive(:note_as_json).with(:note){ :json }
      expect(controller).to receive(:render).with(json:{note: :json}){ :render }
    end
    it{ subject }
  end

  describe "#update" do
    let(:function){ :update }
    let(:params){{ id: :id }}
    before do
      expect(controller).to receive(:note_params).with(no_args){ :params }
      expect(controller).to receive(:render).with(json:{note: :json}){ :render }
      expect(repo).to receive(:note).with(:id){ :note }
      expect(repo).to receive(:update_note).with(:note,:params){ :updated_note }
      expect(repo).to receive(:note_as_json).with(:note){ :json }
    end
    it{ subject }
  end

  describe "#destroy" do
    let(:function){ :destroy }
    let(:params){{ id: :id }}
    let(:note){ double :note }
    before do
      expect(controller).to receive(:render).with(json:{note: :json}){ :render }
      expect(repo).to receive(:note).with(:id){ note }
      expect(note).to receive(:full_json).with(no_args){ :json }
      expect(note).to receive(:delete).with(no_args){ note }
    end
    it{ should eq :render }
  end

end
