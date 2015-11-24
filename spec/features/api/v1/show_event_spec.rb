require 'rails_helper'

describe "Show event" do

  let(:parent){ create :event, title:"Green wedding" }
  let(:event){ create :event, title:"Red wedding", parent:parent }
  let(:article){ create :article, name:"Ethenielle" }
  let(:participation){
    create :participation, article_id:article.id, event_id:event.id }

  before do
    participation
    visit api_event_path event
  end

  subject(:response){ JSON.parse(page.text)['event'] }

  it "Event exists" do
    should eq(
    { 'id'       => event.id,
      'title'    => "Red wedding",
      'parent'   =>
      { 'id'       => parent.id,
        'title'    => "Green wedding" },
      'articles' => 
      [{'id'       => article.id,
        'name'     => "Ethenielle" }]})
  end

  after do
    Participation.delete_all
    Article.delete_all
    Event.delete_all
    Universe.delete_all
  end
    

end
