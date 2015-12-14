require 'rails_helper'

describe "Show note" do

  let(:body){ JSON.parse(page.text)["note"] }
  let(:article){ create :article, name:"a name" }
  let(:note){ create :note, text:"a note" }
  let(:tag){ create :tag, title:'TDP' }
  let(:tagging){ create :note_tag, tag:tag, note:note }
  let(:reference){ create :reference, params }
  let(:article_note){ create :article_note, article:article, note:note }
  let(:params){{ comment:"smart", referenceable:note, url:"www.example.com" }}

  before do
    article_note
    tagging; reference
    visit api_note_path note
  end

  subject{ body }
    
  it "Note exists" do
    is_expected.to eq({
      'id'         => note.id,
      'text'       => "a note",
      'article'    => {
        'id'         => article.id,
        'name'      => "a name" },
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
    ArticleNote.delete_all
    NoteTag.delete_all
    Tag.delete_all
    Reference.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end


end
