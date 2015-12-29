require 'rails_helper'

describe "T1 Delete article mentions" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :delete }
  let(:path){ send "api_#{mdls_name}_path" }
  let(:mdls_name){ mdl_name.pluralize }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdls_name] }
  let(:mdl){ create mdl_name, content:"some content" }

  let(:mdl_name){ "article_mention" }
  let(:origin){ Event.first }
  let(:target){ Article.first }

  before{ header; mdl }

  subject{ ->{ driver.submit mode, path, nil }}

  it "Successfully" do
    should change(ArticleMention,:count).from(1).to(0)
    expect(response).to eq([
      'id'      => mdl.id,
      'content' => "some content",
      'origin'  => {
        'id'      => origin.id,
        'title'   => "factory title" },
      'target'  => {
        'id'      => target.id,
        'name'    => "factory name" } ])
  end

  after do
    ArticleMention.delete_all
    Article.delete_all
    Event.delete_all
    Universe.delete_all
  end

end
