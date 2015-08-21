require 'rails_helper'

describe 'Show note' do

  let(:body){ JSON.parse(page.text)['note'] }
  let(:article){ note.article }
  let(:article_id){ article.id }
  let(:note){ create :note, text:'a note' }
  let(:note_id){ note.id }
  let(:tag){ create :tag, title:'TDP', tagable_id:note_id, tagable_type:'Note' }
  let(:tag_id){ tag.id }
  let(:reference){ create :reference, params }
  let(:params){{ comment:"smart", note:note, url:"www.example.com" }}
  let(:reference_id){ reference.id }

  before do
    tag; reference
    visit api_note_path note
  end

  subject{ body }
    
  it "Note exists" do
    is_expected.to eq({
      'id'         => note_id,
      'article_id' => article_id,
      'text'       => 'a note',
      'tags'       => [
        'id'       => tag_id,
        'title'    => "TDP"
      ],
      'references' => [
        'id'         => reference_id,
        'comment'    => "smart",
        'url'        => "www.example.com"
      ]
    })
  end

  after do
    Reference.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end


end
