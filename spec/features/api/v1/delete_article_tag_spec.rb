require 'rails_helper'

describe "Delete article tag" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :delete }
  let(:path){ send "api_#{mdl_name}_path", mdl.id }

  let(:mdl_name){ "tag" }
  let(:params){{ mdl_name => { tagable_id:article.id, tagable_type:"Article" }}}
  let(:mdl){ create mdl_name, universe_id:universe_id }
  let(:article){ create :article }
  let(:universe_id){ article.universe_id }
  let(:tagging){ create :article_tag, article:article, tag:mdl }

  before{ tagging }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(ArticleTag,:count).from(1).to(0).and(
           not_change(Tag,:count).from(1)).and(
           not_change(Article,:count).from(1)).and(
           not_change(Universe,:count).from(1))
    expect(page.status_code).to be 200
  end

  after do
    ArticleTag.delete_all
    Tag.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
