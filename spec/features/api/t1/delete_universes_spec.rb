require 'rails_helper'

describe "T1 Delete universes" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :delete }
  let(:path){ send "api_#{mdls_name}_path" }
  let(:mdls_name){ mdl_name.pluralize }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdls_name] }
  let(:mdl){ create mdl_name, title:"The Path of Daggers" }

  let(:mdl_name){ "universe" }

  before{ header; mdl }

  subject{ ->{ driver.submit mode, path, nil }}

  it "Existing universes are deleted" do
    should change(Universe,:count).from(1).to(0)
    expect(response).to eq([{
      'id'    => mdl.id,
      'title' => "The Path of Daggers" }])
  end

  after do
    Universe.delete_all
  end

end
