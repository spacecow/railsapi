describe "Api::T1::NotesController" do

  let(:controller){ Api::T1::NotesController.new }
  let(:factory){ double :factory }
  let(:note){ double :note }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/t1/notes_controller'
    expect(controller).to receive(:factory).with(no_args){ factory }
    allow(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "#index" do
    let(:function){ :index }
    before do
      expect(factory).to receive(:notes).with(no_args){ [note] }
      expect(note).to receive(:factory_json).with(no_args){ :json }
      expect(controller).to receive(:render).
        with(json:{notes:[:json]}){ :render }
    end
    it{ should be :render }
  end

  describe "#create" do
    let(:function){ :create }
    let(:params){{ note: :note }}
    before do
      expect(factory).to receive(:create_note).with(:note){ note }
      expect(note).to receive(:factory_json).with(no_args){ :json }
      expect(controller).to receive(:render).
        with(json:{note: :json}){ :render }
    end
    it{ should be :render }
  end

end
