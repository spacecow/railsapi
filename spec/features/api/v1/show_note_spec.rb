require 'rails_helper'

describe "Show note" do

  let(:body){ JSON.parse(page.text)['note'] }
  let(:article){ note.article }
  let(:note){ create :note, text:'a note' }
  let(:tag){ create :tag, title:'TDP' }
  let(:tagging){ create :tagging, tag:tag, tagable:note }
  let(:reference){ create :reference, params }
  let(:params){{ comment:"smart", note:note, url:"www.example.com" }}

  before do
    tagging; reference
    visit api_note_path note
  end

  subject{ body }
    
  it "Note exists" do
    is_expected.to eq({
      'id'         => note.id,
      'article_id' => article.id,
      'text'       => 'a note',
      'tags'       => [
        'id'       => tag.id,
        'title'    => "TDP"
      ],
      'references' => [
        'id'         => reference.id,
        'comment'    => "smart",
        'url'        => "www.example.com"
      ]
    })
  end

  after do
    Tagging.delete_all
    Tag.delete_all
    Reference.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end


end
