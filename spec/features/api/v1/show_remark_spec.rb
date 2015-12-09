require 'rails_helper'

describe "Show remark" do

  let(:response){ JSON.parse(page.text)['remark'] }
  let(:remark){ create :remark, content:"a remark" }

  before{ visit api_remark_path remark }

  it "Remark exists" do
    expect(response).to eq({
      'id'      => remark.id,
      'content' => "a remark" })
  end

  after do
    Remark.delete_all 
    Remarkable.delete_all
  end

end
