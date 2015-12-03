require 'rails_helper'

describe 'Show article' do

  let(:body){ JSON.parse(page.text)['article'] }
  let(:dog){ create :article, name:"dog" }
  let(:relation){ create :relation, origin:dog, target:article }
  let(:article){ create :article, name:'Vin' }
  let(:universe){ article.universe }
  let(:note){ create :note, article:article, text:'a note' }
  let(:tagging){ create :tagging, tagable_id:note.id, tag_id:tag.id, tagable_type:'Note' }
  let(:tag){ create :tag, title:'TDP' }
  let(:participation){ create :participation, participant:article, event:event }
  let(:reference){ create :reference, referenceable:relation, comment:"a comment" }
  let(:event){ create :event, title:"an event" }

  before do
    note
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
      'name'        => 'Vin',
      'universe_id' => universe.id,
      'type'        => 'Character',
      'notes'       => [
        'id'          => note.id,
        'text'        => 'a note',
        'tags'        => [
          'id'          => tag.id,
          'title'       => 'TDP' ] ],
      'relatives' => [{
        'id'        => relation.id,
        'type'      => 'Owns',
        'references' => [{
          'id'      => reference.id,
          'comment' => 'a comment' }],
        'target'    => {
          'id'        => dog.id,
          'name'      => "dog" } }],
      'events'    => [
        'id'        => event.id,
        'title'     => "an event" ] })
  end

  after do
    Reference.delete_all
    Participation.delete_all
    Relation.delete_all
    Tagging.delete_all
    Tag.delete_all
    Note.delete_all
    Event.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
