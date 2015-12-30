require 'rails_helper'

describe "Show article mention" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :get }
  let(:path){ send "api_#{mdl_name}_path", mdl  }
  let(:header){ driver.header 'Accept', 'application/vnd.example.v1' }
  let(:mdl){ create mdl_name, content:"some content" }
  let(:response){ JSON.parse(page.text)[mdl_name] }

  let(:mdl_name){ "article_mention" }

  let(:function){ driver.submit mode, path, nil }
  before{ header; function }
  let(:origin){ Event.first }
  let(:target){ Article.first }

  subject{ response }

  it "Successfully" do should eq(
    'id'      => mdl.id,
    'content' => "some content",
    'origin'  => {
      'id'      => origin.id,
      'title'   => "factory title" },
    'target'  => {
      'id'      => target.id,
      'name'    => "factory name" })
  end

  after do
    ArticleMention.delete_all
    Article.delete_all
    Event.delete_all
    Universe.delete_all
  end

end
