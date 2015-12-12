require 'rails_helper'

describe "T1 Delete events" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :delete }
  let(:path){ send "api_#{mdls_name}_path" }
  let(:mdls_name){ mdl_name.pluralize }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdls_name] }
  let(:mdl){ create mdl_name }

  let(:mdl_name){ "event" }

  before{ header; mdl }

  subject{ ->{ driver.submit mode, path, nil }}

  it "Successfully" do
    should change(Event,:count).from(1).to(0)
    expect(response).to be 1 
  end

  after do
    Event.delete_all
    Universe.delete_all
  end

end
