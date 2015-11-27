require 'rails_helper'

describe "Create relation" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdl] }
  let(:path){ send "api_#{mdl.pluralize}_path" }

  let(:mode){ :post }
  let(:origin){ create :article }
  let(:target){ create :article }
  let(:params){{ relation:{ origin_id:origin.id, target_id:target.id, type:"Owner" }}}
  let(:mdl){ "relation" }
  let(:relation){ Relation.first }

  subject{ ->{ driver.submit mode, path, params }}

  it "a relation is created" do
    should change(Relation,:count).from(0).to(1)
    expect(response).to eq(
    { 'id'        => relation.id,
      'origin_id' => origin.id,
      'target_id' => target.id })
  end

  after do
    Relation.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
