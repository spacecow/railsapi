require 'rails_helper'

describe "T1 Create remark" do

  let(:driver){ Capybara.current_session.driver }
  let(:path){ send "api_#{mdl.pluralize}_path" }
  let(:response){ JSON.parse(page.text)[mdl] }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:mode){ :post }

  let(:mdl){ "remark" }
  let(:params){{ remark:{ content:"a remark" }}}
  let(:remark){ Remark.first }

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(Remark,:count).from(0).to(1)
    expect(response).to eq({
      'id'      => remark.id,
      'content' => "a remark" })
  end

  after do
    Remark.delete_all
    Remarkable.delete_all
  end

end
