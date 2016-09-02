require 'rails_helper'

describe "T1 Create tag" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :post }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdl_name] }

  let(:mdl_name){ "tag" }
  let(:universe){ create :universe } 
  let(:params){{ mdl_name => { title:"Warder", universe_id:universe.id }}}
  let(:tag){ mdl_name.camelize.constantize.first }

  before{ header; universe }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(Tag,:count).from(0).to(1).and(
           not_change(ArticleTag,:count).from(0)).and(
           not_change(Universe,:count).from(1))
    expect(response).to eq({
      'id'          => tag.id,
      'title'       => "Warder",
      'universe_id' => universe.id })
    expect(tag.title).to eq "Warder" 
    expect(tag.universe_id).to be universe.id 
  end

  after do
    Tag.delete_all
    Universe.delete_all
  end

end
