require 'rails_helper'

describe "T1 Create tag" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :post }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdl_name] }

  let(:mdl_name){ "tag" }
  let(:params){{ mdl_name => { title:"Warder" }}}
  let(:tag){ mdl_name.camelize.constantize.first }

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(Tag,:count).from(0).to(1).and(
           change(ArticleTag,:count).by(0))
    expect(response).to eq({
      'id'    => tag.id,
      'title' => "Warder" })
    expect(tag.title).to eq "Warder" 
  end

  after do
    Tag.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
