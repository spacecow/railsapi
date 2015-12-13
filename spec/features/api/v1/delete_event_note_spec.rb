require 'rails_helper'

describe "Delete event note" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdl_name] }
  let(:path){ send "api_#{mdl_name}_path", mdl.id }
  let(:mode){ :delete }

  let(:mdl_name){ "note" }
  let(:event){ create :event, title:"a title" }
  let(:noting){ create :event_note, event:event, note:mdl }
  let(:mdl){ create mdl_name, text:"Everyone got killed" }

  before{ noting }

  subject{ ->{ driver.submit mode, path, nil }}

  it "Successfully" do
    should change(Note,:count).from(1).to(0).and(
           change(EventNote,:count).from(1).to(0))
    expect(response).to eq(
      'id'      => mdl.id,
      'text'    => "Everyone got killed",
      'event'   => {
        'id'      => event.id,
        'title'   => "a title" })
  end

  after do
    EventNote.delete_all
    Note.delete_all
    Event.delete_all
    Universe.delete_all
  end

end
