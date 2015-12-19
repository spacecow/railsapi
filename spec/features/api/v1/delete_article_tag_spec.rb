require 'rails_helper'

describe "Delete article tag" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :delete }
  let(:path){ send "api_#{mdl_name}_path", mdl.id }

  let(:mdl_name){ "tag" }
  let(:params){{ mdl_name => { tagable_id:article.id, tagable_type:"Article" }}}
  let(:mdl){ create mdl_name }
  let(:article){ create :article }
  let(:tagging){ create :article_tag, article:article, tag:mdl }

  before{ tagging }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(ArticleTag,:count).from(1).to(0).and(
           change(Tag,:count).by(0))
    expect(page.status_code).to be 200
  end

  after do
    ArticleTag.delete_all
    Tag.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
