require 'rails_helper'

describe "T1 Create citation" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :post }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdl_name] }
  let(:mdl){ mdl_name.camelize.constantize.first }

  let(:mdl_name){ "citation" }
  let(:params){{ mdl_name => { content:"Twice and twice" }}}

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(Citation,:count).from(0).to(1)
    expect(response).to eq({
      'id'      => mdl.id,
      'content' => "Twice and twice" })
    expect(mdl.content).to eq "Twice and twice" 
  end

  after do
    Citation.delete_all
  end

end
