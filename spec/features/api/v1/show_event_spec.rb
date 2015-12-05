require 'rails_helper'

describe "Show event" do

  let(:parent){ create :event, title:"Green wedding" }
  let(:parent_step){ create :step, parent:parent, child:event }
  let(:event){ create :event, title:"Red wedding" }
  let(:child_step){ create :step, parent:event, child:child }
  let(:child){ create :event, title:"Yellow wedding" }
  let(:article){ create :article, name:"Ethenielle" }
  let(:participation){
    create :participation, participant:article, event:event }

  before do
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
    Step.delete_all
    Participation.delete_all
    Article.delete_all
    Event.delete_all
    Universe.delete_all
  end
    

end
