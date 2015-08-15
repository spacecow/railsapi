require 'rails_helper'

describe 'Show article' do

  let(:body){ JSON.parse(page.text)['article'] }
  let(:article){ create :article, name:'Vin' }
  let(:article_id){ article.id }
  let(:universe){ article.universe }
  let(:universe_id){ universe.id }
  let(:note){ create :note, article:article }
  let(:note_id){ note.id }

  context 'Article exists' do
    before do
      note
      visit api_article_path article
    end
    subject{ body }
    it{ subject }
    it{ is_expected.to eq({
      'id' => article_id,
      'name' => 'Vin',
      'universe_id' => universe_id,
      'type' => 'Character',
      'notes' => [
        'id' => note_id ] }) }
  end

  after do
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
