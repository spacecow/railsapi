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
  let(:universe){ Universe.first }

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(Event,:count).from(0).to(1)
    expect(response).to eq({
      'id'       => mdl.id,
      'title'    => "a title",
      'universe' => {
        'id'       => universe.id,
        'title'    => universe.title }
    })
    expect(mdl.title).to eq "a title"
    expect(mdl.universe_id).to eq universe.id 
  end

  after do
    Event.delete_all
    Universe.delete_all
  end

end
