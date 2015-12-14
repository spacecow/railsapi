require 'rails_helper'

describe 'Show article' do

  let(:body){ JSON.parse(page.text)['article'] }
  let(:dog){ create :article, name:"dog", gender:'n' }
  let(:relation){ create :relation, origin:dog, target:article }
  let(:article){ create :article, name:'Vin', gender:'f' }
  let(:universe){ article.universe }
  let(:article_note){ create :article_note, article:article, note:note }
  let(:note){ create :note, text:'a note' }
  let(:tagging){ create :note_tag, note_id:note.id, tag_id:tag.id }
  let(:tag){ create :tag, title:'TDP' }
  let(:participation){ create :participation, participant:article, event:event }
  let(:reference){ create :reference, referenceable:relation, comment:"a comment" }
  let(:event){ create :event, title:"an event" }

  before do
    article_note
    tagging
    relation
    participation
    reference
    visit api_article_path article
  end

  subject{ body }

  it "Article exists" do
     is_expected.to eq({
      'id'          => article.id,
      'name'        => "Vin",
      'universe_id' => universe.id,
      'type'        => "Character",
      'gender'      => 'f',
      'notes'       => [
        'id'          => note.id,
        'text'        => 'a note',
        'tags'        => [
          'id'          => tag.id,
          'title'       => 'TDP' ]
      ],
      'relatives' => [{
        'id'        => relation.id,
        'type'      => 'Owns',
        'references' => [{
          'id'      => reference.id,
          'comment' => 'a comment' }],
        'target'    => {
          'id'        => dog.id,
          'gender'    => 'n',
          'name'      => "dog" } }],
      'events'    => [
        'id'        => event.id,
        'title'     => "an event" ] 
    })
  end

  after do
    ArticleNote.delete_all
    Reference.delete_all
    Participation.delete_all
    Relation.delete_all
    NoteTag.delete_all
    Tag.delete_all
    Note.delete_all
    Event.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
