require 'rails_helper'

describe "T1 Create note" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :post }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:mdl){ mdl_name.camelize.constantize.first }
  let(:response){ JSON.parse(page.text)[mdl_name] }

  let(:mdl_name){ "note" }
  let(:params){{ mdl_name => { text:"a note" }}}

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(Note,:count).from(0).to(1)
    expect(response).to eq({
      'id'       => mdl.id,
      'text'     => "a note" })
    expect(mdl.text).to eq "a note"
  end

  after do
    Note.delete_all 
    # remove article when association is removed
    Article.delete_all
    Universe.delete_all
  end

end
