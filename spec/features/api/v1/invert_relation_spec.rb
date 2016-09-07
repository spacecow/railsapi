require 'rails_helper'

describe "Invert relation" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :put }
  let(:path){ send "invert_api_#{mdl_name}_path", mdl }
  let(:response){ JSON.parse(page.text) }

  let(:mdl_name){ "relation" }
  let(:origin){ create :article }
  let(:target){ create :article }
  let(:mdl){ create :relation, origin:origin, target:target }
  let(:params){ {} }

  before{ mdl }

  subject{ ->{ driver.submit mode, path, params }}

  it "Origin and Target are switched" do
    should not_change(Relation, :count).and(
           not_change(Article, :count).from(2)).and(
           not_change(Universe, :count).from(2))
    #TODO The universe must be the same, count should be 1
    expect(response).to eq({"relation" => {"id" => mdl.id}})
    mdl.reload
    expect(mdl.origin_id).to be target.id 
    expect(mdl.target_id).to be origin.id 
  end

  after do
    Relation.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
