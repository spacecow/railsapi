require 'rails_helper'

describe "T1 Delete note notes" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :delete }
  let(:path){ send "api_#{mdls_name}_path" }
  let(:mdls_name){ mdl_name.pluralize }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdls_name] }
  let(:mdl){ create mdl_name }

  let(:mdl_name){ "event_note" }
  let(:event){ Event.first }
  let(:note){ Note.first }

  before{ header; mdl }

  subject{ ->{ driver.submit mode, path, nil }}

  it "Successfully" do
    should change(EventNote,:count).from(1).to(0)
    expect(response).to eq([{
      'id'       => mdl.id,
      'event_id' => event.id,
      'note_id'  => note.id }])
  end

  after do
    EventNote.delete_all
    Note.delete_all
    Event.delete_all
    Universe.delete_all
  end

end
