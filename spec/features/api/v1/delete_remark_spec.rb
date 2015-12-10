require 'rails_helper'

describe "Delete remark" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdl_name] }
  let(:mode){ :delete }
  let(:path){ send "api_#{mdl_name}_path", mdl }
  let(:mdl_name){ mdl.class.to_s.downcase }

  let(:mdl){ create :remark, content:"a remark" }

  before{ mdl }

  subject{ ->{ driver.submit mode, path, nil }}

  it "note is deleted" do
    should change(Remark,:count).from(1).to(0)
    expect(response).to eq({
      'id'      => mdl.id,
      'content' => "a remark" })
  end

  after do
    Remarkable.delete_all
    Remark.delete_all
  end

end
