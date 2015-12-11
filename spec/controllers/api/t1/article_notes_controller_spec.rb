describe "Api::T1::ArticleNotesController" do

  let(:controller){ Api::T1::ArticleNotesController.new }
  let(:factory){ double :factory }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/t1/article_notes_controller'
  end

  subject{ controller.send function }

  describe "#delete_all" do
    let(:function){ :delete_all }
    let(:article_note){ double :article_note }
    before do
      expect(controller).to receive(:factory).with(no_args){ factory }
      expect(controller).to receive(:render).
        with(json:{article_notes:[:json]}){ :render }
      expect(factory).to receive(:delete_article_notes).
        with(no_args){ [article_note] }
      expect(article_note).to receive(:full_json).with(no_args){ :json }
    end
    it{ subject }
  end

end
