require 'rails_helper'

describe "Delete event" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdl] }
  let(:path){ send "api_#{mdl}_path", event.id }

  let(:mode){ :delete }
  let(:mdl){ "event" }
  let(:event){ create :event, title:"Red wedding" }

  before{ event }

  subject{ ->{ driver.submit mode, path, nil }}

  it "article is deleted" do
    should change(Event,:count).from(1).to(0)
    expect(response).to eq({
      'id'           => event.id,
      'title'        => "Red wedding",
      'participants' => [],
      'parents'      => [],
      'children'     => []
    })
  end

  after do
    Event.delete_all
    Universe.delete_all
  end

end
