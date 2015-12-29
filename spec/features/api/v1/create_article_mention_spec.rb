require 'rails_helper'

describe "Create article mention" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :post }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.v1' }
  let(:response){ JSON.parse(page.text)[mdl_name] }
  let(:mdl){ mdl_name.camelize.constantize.first }

  let(:mdl_name){ "article_mention" }
  let(:params){{ mdl_name => { origin_id:origin.id, target_id:target.id }}}
  let(:origin){ create :event, title:"a title" }
  let(:target){ create :article, name:"a name" }

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "a participation is created" do
    should change(ArticleMention,:count).from(0).to(1)
    expect(response).to eq(
      'id'      => mdl.id,
      'content' => nil,
      'origin'  => {
        'id'      => origin.id,
        'title'   => "a title" },
      'target'  => {
        'id'      => target.id,
        'name'    => "a name" })
    expect(mdl.origin_id).to be origin.id
    expect(mdl.target_id).to be target.id
  end

  after do
    ArticleMention.delete_all
    Article.delete_all
    Event.delete_all
    Universe.delete_all
  end

end
