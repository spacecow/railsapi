require 'rails_helper'

describe 'Show tag' do

  let(:universe){ create :universe } 
  let(:body){ JSON.parse(page.text)['tag'] }
  let(:tag){ create :tag, title:'TDP', universe_id:universe.id }
  let(:tagging){ create :note_tag, note_id:note.id, tag_id:tag.id }
  let(:note){ create :note }

  subject{ body }

  before do
    tagging
    visit api_tag_path tag
  end

  it "Tag exists" do
    should eq({
      'id'         => tag.id,
      'title'      => 'TDP',
      'article_id' => nil,
      'notes'      => [
        'id'         => note.id,
        'text'       => 'factory text'
      ]
    })
  end

  after do
    NoteTag.delete_all
    Tag.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
