require 'rails_helper'

describe "Update event" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :put }
  let(:path){ send "api_#{mdl_name}_path", event }
  let(:response){ JSON.parse(page.text)[mdl_name] }

  let(:mdl_name){ "event" }
  let(:event){ create mdl_name, title:"an old title" }
  let(:params){{ mdl_name => { title:"an updated title" }}}

  before{ event }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should_not change(Event,:count) 
    expect(response).to eq({
      'id'             => event.id,
      'title'          => "an updated title",
      'children'       => [],
      'parents'        => [],
      'participations' => [],
      'mentions'       => [],
      'notes'          => [] })
    event.reload
    expect(event.title).to eq "an updated title"
  end

  after do
    Event.delete_all
    Universe.delete_all
  end

end
