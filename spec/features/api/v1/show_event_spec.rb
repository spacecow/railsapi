require 'rails_helper'

describe "Show event" do

  let(:parent){ create :event, title:"Green wedding" }
  let(:parent_step){ create :step, parent:parent, child:event }
  let(:event){ create :event, title:"Red wedding", remarkable:remarkable }
  let(:child_step){ create :step, parent:event, child:child }
  let(:child){ create :event, title:"Yellow wedding" }
  let(:remarkable){ create :remarkable }
  let(:remark){ create :remark, remarkable:remarkable, content:"a remark" }
  let(:article){ create :article, name:"Ethenielle" }
  let(:participation){ create :participation, participant:article, event:event }

  before do
    remark
    parent_step
    child_step
    participation
    visit api_event_path event
  end

  subject(:response){ JSON.parse(page.text)['event'] }

  it "Event exists" do
    should eq(
    { 'id'           => event.id,
      'title'        => "Red wedding",
      'remarks'      => [
        'id'           => remark.id,
        'content'      => "a remark"], 
      'parents'      => [{
        'id'           => parent.id,
        'title'        => "Green wedding" }],
      'children'     => [{
        'id'           => child.id,
        'title'        => "Yellow wedding" }],
      'participants' => [{
        'id'           => article.id,
        'gender'       => 'n',
        'name'         => "Ethenielle" }]})
  end

  after do
    Remark.delete_all
    Step.delete_all
    Participation.delete_all
    Article.delete_all
    Event.delete_all
    Remarkable.delete_all
    Universe.delete_all
  end
    

end
