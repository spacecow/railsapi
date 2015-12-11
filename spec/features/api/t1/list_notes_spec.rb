require 'rails_helper'

describe "T1 List notes" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :get }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:mdl){ create :note, text:"a random text" }
  let(:response){ JSON.parse(page.text)[mdl_name.pluralize] }

  let(:mdl_name){ "note" }
  let(:params){{}}

  before do
    header
    mdl
    driver.submit mode, path, params
  end

  it "Successfully" do
    expect(response).to eq([{
      'id'   => mdl.id,
      'text' => "a random text" }])
  end

  after do
    Note.delete_all
    Article.delete_all #TODO delete when article is taken out of
    Universe.delete_all#note model as association
  end

end
