require 'rails_helper'

describe "T1 Create article tag" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :post }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdl_name] }

  let(:mdl_name){ "tag" }
  let(:tag){ mdl_name.camelize.constantize.first }
  let(:tagging){ ArticleTag.first }
  let(:article){ create :article }
  let(:universe_id){ article.universe_id }
  let(:params){{ mdl_name => {
    tagable_id:article.id, tagable_type:"Article", universe_id:universe_id }}}

  before{ header; article }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(ArticleTag,:count).from(0).to(1).and(
           change(Tag,:count).from(0).to(1)).and(
           not_change(Universe,:count).from(1)).and(
           not_change(Article,:count).from(1))
    expect(response).to eq({
      'id'          => tag.id,
      'title'       => "factory title",
      'universe_id' => universe_id })
    expect(tag.title).to eq "factory title" 
    expect(tag.universe_id).to eq universe_id 
    expect(tagging.article_id).to be article.id 
    expect(tagging.tag_id).to be tag.id 
  end

  after do
    ArticleTag.delete_all
    Tag.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
