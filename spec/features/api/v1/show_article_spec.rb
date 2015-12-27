require 'rails_helper'

describe 'Show article' do

  let(:body){ JSON.parse(page.text)['article'] }
  let(:dog){ create :article, name:"dog", gender:'n' }
  let(:relation){ create :relation, origin:dog, target:article }
  let(:article){ create :article, name:'Vin', gender:'f' }
  let(:article2){ create :article, name:"animal" }
  let(:universe){ article.universe }
  let(:article_note){ create :article_note, article:article, note:note }
  let(:note){ create :note, text:'a note' }
  let(:note_tag){ create :note_tag, note_id:note.id, tag_id:tag.id }
  let(:tag){ create :tag, title:'TDP' }
  let(:article_tag){ create :article_tag, article_id:article.id, tag_id:tag2.id }
  let(:tag2){ create :tag, title:'animal' }
  let(:participation){ create :participation, participant:article, event:event }
  let(:reference){ create :reference, referenceable:relation, comment:"a comment" }
  let(:event){ create :event, title:"an event" }
  let(:citation_target){ create :article, name:"a citation target" }
  let(:citation){ create :citation, origin:article, content:"hell yeah",
    target:citation_target }
  let(:citation_origin){ create :article, name:"a citation origin" }
  let(:citation2){ create :citation, target:article, content:"hell2 yeah",
    origin:citation_origin }

  before do
    citation; citation2
    article2
    article_note
    article_tag
    note_tag
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
      'citations'   => [
        'id'          => citation.id,
        'content'     => "hell yeah",
        'target'      => {
          'id'          => citation_target.id,
          'name'        => "a citation target",
          'gender'      => 'n'
        }
      ],
      'inverse_citations' => [
        'id'                => citation2.id,
        'content'           => "hell2 yeah",
        'origin'      => {
          'id'          => citation_origin.id,
          'name'        => "a citation origin",
          'gender'      => 'n'
        }
      ],
      'notes'       => [
        'id'          => note.id,
        'text'        => 'a note',
        'tags'        => [
          'id'          => tag.id,
          'title'       => 'TDP'
        ]
      ],
      'tags'        => [
        'id'          => tag2.id,
        'title'       => "animal",
        'article_id'  => article2.id 
      ],
      'relatives'   => [{
        'id'          => relation.id,
        'type'        => 'Owns',
        'references'  => [{
          'id'          => reference.id,
          'comment'     => 'a comment' }],
        'target'      => {
          'id'          => dog.id,
          'gender'      => 'n',
          'name'        => "dog" } }],
      'events'      => [
        'id'          => event.id,
        'title'       => "an event" ] 
    })
  end

  after do
    Citation.delete_all
    ArticleNote.delete_all
    Reference.delete_all
    Participation.delete_all
    Relation.delete_all
    NoteTag.delete_all
    ArticleTag.delete_all
    Tag.delete_all
    Note.delete_all
    Event.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
