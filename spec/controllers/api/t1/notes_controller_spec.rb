describe "Api::T1::NotesController" do

  let(:controller){ Api::T1::NotesController.new }
  let(:factory){ double :factory }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/t1/notes_controller'
    expect(controller).to receive(:factory).with(no_args){ factory }
  end

  subject{ controller.send function }

  describe "#index" do
    let(:function){ :index }
    let(:note){ double :note }
    before do
      expect(factory).to receive(:notes).with(no_args){ [note] }
      expect(note).to receive(:factory_json).with(no_args){ :json }
      expect(controller).to receive(:render).
        with(json:{notes:[:json]}){ :render }
    end
    it{ subject }
  end

end
