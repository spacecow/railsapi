require 'rails_helper'

describe "Update relation" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :put }
  let(:path){ send "api_#{mdl_name}_path", mdl }
  let(:response){ JSON.parse(page.text) }

  let(:mdl_name){ "relation" }
  let(:origin){ create :article }
  let(:target){ create :article }
  let(:new_origin){ create :article }
  let(:new_target){ create :article }
  let(:mdl){ create mdl_name, origin:origin, target:target, type:"Employee" }
  let(:params){{ mdl_name => { type:"Owner", origin_id:new_origin.id, target_id:new_target.id }}}

  subject{ ->{ driver.submit mode, path, params }}

  before{ mdl; new_origin; new_target }

  it "Successfully" do
    should not_change(Relation, :count).from(1).and(
           not_change(Article, :count).from(4)).and(
           not_change(Universe, :count).from(4))
    #TODO universe count should be 1
    expect(response).to eq({"relation" => {"id" => mdl.id }})
    mdl.reload
    expect(mdl.type).to eq "Owner"
    expect(mdl.origin_id).to be new_origin.id 
    expect(mdl.target_id).to be new_target.id 
  end

  after do
    Relation.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
