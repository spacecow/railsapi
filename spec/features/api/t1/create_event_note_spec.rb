require 'rails_helper'

describe "T1 Create event note" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :post }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdl_name] }
  let(:mdl){ mdl_name.camelize.constantize.first }

  let(:mdl_name){ "event_note" }
  let(:params){{ mdl_name => { event_id:event.id }}}
  let(:event){ create :event }
  let(:note){ Note.first }

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(EventNote,:count).from(0).to(1)
    expect(response).to eq({
      'id' => mdl.id,
      'event_id' => event.id,
      'note_id' => note.id })
    expect(mdl.event_id).to eq event.id 
    expect(mdl.note_id).to eq note.id 
  end

  after do
    EventNote.delete_all
    Note.delete_all
    Event.delete_all
    Universe.delete_all
  end

end
