require 'rails_helper'

describe "Update remark" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdl] }
  let(:path){ send "api_#{mdl}_path", remark }
  let(:mode){ :put }

  let(:mdl){ "remark" }
  let(:params){{ remark:{ content:"updated remark" }}}
  let(:remark){ create :remark }

  before{ remark }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should_not change(Remark,:count) 
    expect(response).to eq({
      'id'          => remark.id,
      'content'     => "updated remark"
    })
    expect(remark.reload.content).to eq "updated remark"
  end

  after do
    Remark.delete_all
    Remarkable.delete_all
  end

end
