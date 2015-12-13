
require 'rails_helper'

describe "Create event note" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :post }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.v1' }
  let(:response){ JSON.parse(page.text)[mdl_name] }
  let(:mdl){ mdl_name.camelize.constantize.first }

  let(:mdl_name){ "note" }
  let(:event){ create :event, title:"a title" }
  let(:params){{ mdl_name => { event_id:event.id, text:"a note" }}}

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(Note,:count).from(0).to(1).and(
           change(EventNote,:count).from(0).to(1))
    expect(response).to eq({
      'id'    => Note.first.id,
      'text'  => "a note",
      'event' => {
        'id'    => event.id,
        'title' => "a title" }})
    expect(mdl.text).to eq "a note"
    expect(mdl.article_id).to be nil 
    expect(mdl.event_id).to eq event.id
  end

  after do
    EventNote.delete_all
    Note.delete_all
    Event.delete_all
    Universe.delete_all
  end

end
