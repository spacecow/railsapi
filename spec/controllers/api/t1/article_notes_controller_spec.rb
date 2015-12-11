describe "Api::T1::ArticleNotesController" do

  let(:controller){ Api::T1::ArticleNotesController.new }
  let(:factory){ double :factory }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/t1/article_notes_controller'
    expect(controller).to receive(:factory).with(no_args){ factory }
    allow(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    let(:params){{ article_note: :params }}
    let(:article_note){ double :article_note }
    before do
      expect(controller).to receive(:render).
        with(json:{article_note: :json}){ :render }
      expect(factory).to receive(:create_article_note).
        with(:params){ article_note }
      expect(article_note).to receive(:factory_json).with(no_args){ :json }
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
      expect(article_note).to receive(:factory_json).with(no_args){ :json }
    end
    it{ should be :render }
  end

end
