require 'rails_helper'

describe "Create citation" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :post }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.v1' }
  let(:response){ JSON.parse(page.text)[mdl_name] }
  let(:mdl){ mdl_name.camelize.constantize.first }

  let(:mdl_name){ "citation" }
  let(:params){{ mdl_name => { content:"some content", origin_id:origin.id }}}
  let(:origin){ create :article }

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "a participation is created" do
    should change(Citation,:count).from(0).to(1)
    expect(response).to eq(
      'id'      => mdl.id,
      'content' => "some content"
    )
    expect(mdl.content).to eq "some content" 
    expect(mdl.origin_id).to be origin.id 
    expect(mdl.target_id).to be nil
  end

  after do
    Citation.delete_all 
    Article.delete_all
    Universe.delete_all
  end

end
