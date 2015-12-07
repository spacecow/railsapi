require 'rails_helper'

describe "Create event" do

  let(:driver){ Capybara.current_session.driver }
  let(:path){ send "api_#{mdl.pluralize}_path" }
  let(:response){ JSON.parse(page.text)[mdl] }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:mode){ :post }

  let(:mdl){ "event" }
  let(:params){{ event:{ title:"a title" }}}
  let(:event){ Event.first }

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(Event,:count).from(0).to(1)
    expect(response).to eq({
      'id'           => event.id,
      'title'        => "a title",
      'children'     => [],
      'parents'      => [],
      'participants' => [],
      'remarks'      => [] })
  end

  after do
    Event.delete_all
    Universe.delete_all
  end

end
