require 'rails_helper'

describe "Update article mention" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :put }
  let(:path){ send "api_#{mdl_name}_path", mdl  }
  let(:mdl){ create mdl_name, content:"old content" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.v1' }
  let(:response){ JSON.parse(page.text)[mdl_name] }

  let(:mdl_name){ "article_mention" }
  let(:params){{ mdl_name => { content:"updated content" }}}
  let(:origin){ Event.first }
  let(:target){ Article.first }

  before{ header; mdl }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(ArticleMention,:count).by(0)
    expect(response).to eq(
      'id'      => mdl.id,
      'content' => "updated content",
      'origin'  => {
        'id'      => origin.id,
        'title'   => "factory title" },
      'target'  => {
        'id'      => target.id,
        'name'    => "factory name" })
    mdl.reload
    expect(mdl.content).to eq "updated content" 
    expect(mdl.origin_id).to be origin.id
    expect(mdl.target_id).to be target.id
  end

  after do
    ArticleMention.delete_all
    Event.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
