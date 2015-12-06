require 'rails_helper'

describe "Delete remarks" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdls] }
  let(:path){ send "api_#{mdls}_path" }
  let(:mode){ :delete }

  let(:mdls){ "remarks" }
  let(:remark){ create :remark, content:"a remark" }

  before{ remark } 

  subject{ ->{ driver.submit mode, path, nil }}

  it "Existing remarks are deleted" do
    should change(Remark,:count).from(1).to(0)
    expect(response).to eq([{
      'id'      => remark.id,
      'content' => "a remark" }])
  end

  after do
    Remark.delete_all
    Remarkable.delete_all
  end

end
