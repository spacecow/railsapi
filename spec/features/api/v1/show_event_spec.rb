require 'rails_helper'

describe "Show event" do

  let(:parent){ create :event, title:"Green wedding" }
  let(:parent_step){ create :step, parent:parent, child:event }
  let(:event){ create :event, title:"Red wedding" }
  let(:child_step){ create :step, parent:event, child:child }
  let(:child){ create :event, title:"Yellow wedding" }
  let(:article){ create :article, name:"Ethenielle" }
  let(:participation){ create :participation, participant:article, event:event }
  let(:note){ create :note, text:"a note" }
  let(:noting){ create :event_note, event:event, note:note }
  let(:tagging){ create :tagging, tagable_id:note.id, tag_id:tag.id, tagable_type:'Note' }
  let(:tag){ create :tag, title:'TDP' }

  subject(:response){ JSON.parse(page.text)['event'] }

  describe "Successfully" do
    before do
      tagging
      noting
      parent_step
      child_step
      participation
      visit api_event_path event
    end

    it "Event exists" do
      should eq(
      { 'id'           => event.id,
        'title'        => "Red wedding",
        'parents'      => [{
          'id'           => parent.id,
          'title'        => "Green wedding" }],
        'children'     => [{
          'id'           => child.id,
          'title'        => "Yellow wedding" }],
        'participants' => [{
          'id'           => article.id,
          'gender'       => 'n',
          'name'         => "Ethenielle" }],
        'notes'        => [
          'id'           => note.id,
          'text'         => "a note",
          'tags'         => [
            'id'           => tag.id,
            'title'        => "TDP" ]]})
    end
  end

  after do
    Tagging.delete_all
    Tag.delete_all
    EventNote.delete_all
    Note.delete_all
    Step.delete_all
    Participation.delete_all
    Article.delete_all
    Event.delete_all
    Universe.delete_all
  end

end
