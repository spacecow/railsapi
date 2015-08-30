require 'rails_helper'

describe 'Show article' do

  let(:body){ JSON.parse(page.text)['article'] }
  let(:article){ create :article, name:'Vin' }
  let(:article_id){ article.id }
  let(:universe){ article.universe }
  let(:universe_id){ universe.id }
  let(:note){ create :note, article:article, text:'a note' }
  let(:note_id){ note.id }
  let(:tagging){ create :tagging, tagable_id:note_id, tag_id:tag_id, tagable_type:'Note' }
  let(:tag){ create :tag, title:'TDP' }
  let(:tag_id){ tag.id }

  before do
    note; tagging
    visit api_article_path article
  end

  subject{ body }

  it "Article exists" do
     is_expected.to eq({
      'id'          => article_id,
      'name'        => 'Vin',
      'universe_id' => universe_id,
      'type'        => 'Character',
      'notes'       => [
        'id'          => note_id,
        'text'        => 'a note',
        'tags'        => [
          'id'          => tag_id,
          'title'       => 'TDP'
        ]
      ]
    })
  end

  after do
    Tagging.delete_all
    Tag.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
