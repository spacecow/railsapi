require 'rails_helper'

describe "Update relation" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :put }
  let(:path){ send "api_#{mdl_name}_path", mdl }
  let(:response){ JSON.parse(page.text) }

  let(:mdl_name){ "relation" }
  let(:mdl){ create mdl_name, type:"Employee" }
  let(:params){{ mdl_name => { type:"Owner" }}}

  subject{ ->{ driver.submit mode, path, params }}

  before{ mdl }

  it "Successfully" do
    should not_change(Relation, :count).and(
           not_change(Article, :count)).and(
           not_change(Universe, :count))
    expect(response).to eq({})
    mdl.reload
    expect(mdl.type).to eq "Owner"
  end

  after do
    Relation.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
