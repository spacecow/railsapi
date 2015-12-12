require 'rails_helper'

describe "T1 Create remark" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :post }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdl_name] }
  let(:mdl){ mdl_name.camelize.constantize.first }

  let(:mdl_name){ "remark" }
  let(:params){{ mdl_name => { content:"a remark" }}}

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(Remark,:count).from(0).to(1)
    expect(response).to eq({
      'id'      => mdl.id,
      'content' => "a remark" })
    expect(mdl.content).to eq "a remark"
  end

  after do
    Remark.delete_all
    Remarkable.delete_all
  end

end
