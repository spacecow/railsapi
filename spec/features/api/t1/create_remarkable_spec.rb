require 'rails_helper'

describe "Create remarkable" do

  let(:driver){ Capybara.current_session.driver }
  let(:path){ send "api_#{mdl.pluralize}_path" }
  let(:response){ JSON.parse(page.text)[mdl] }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:mode){ :post }

  let(:mdl){ "remarkable" }
  let(:params){{}}
  let(:remarkable){ Remarkable.first }

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(Remarkable,:count).from(0).to(1)
    expect(response).to eq({
      'id' => remarkable.id })
  end

  after do
    Remarkable.delete_all
  end

end
