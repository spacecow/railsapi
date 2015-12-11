require 'rails_helper'

describe "T1 Create event" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :post }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdl_name] }
  let(:mdl){ mdl_name.camelize.constantize.first }

  let(:mdl_name){ "event" }
  let(:params){{ mdl_name => { title:"a title" }}}

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(Event,:count).from(0).to(1)
    expect(response).to eq({
      'id'       => mdl.id,
      'title'    => "a title",
      'universe' => {
        'id'       => mdl.universe_id,
        'title'    => mdl.universe_title }
    })
    expect(mdl.title).to eq "a title"
  end

  after do
    Event.delete_all
    Universe.delete_all
  end

end
