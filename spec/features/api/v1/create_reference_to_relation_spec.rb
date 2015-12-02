require 'rails_helper'

#TODO create inverse relation
describe "Create reference to relation" do

  let(:driver){ Capybara.current_session.driver }
  let(:path){ send "api_#{mdl.pluralize}_path" }
  let(:mode){ :post }
  let(:mdl){ "reference" }

  let(:params){{ reference:{ referenceable_id:relation.id, comment:"a comment",
    referenceable_type:"Relation" }}}
  let(:relation){ create :relation }
  let(:reference){ Reference.first }

  subject{ ->{ driver.submit mode, path, params }}

  it "a reference is created" do
    should change(Reference,:count).from(0).to(1)
    expect(reference.referenceable.id).to be relation.id 
    expect(reference.as_json).to eq({
      "id"                 => reference.id,
      "referenceable_id"   => relation.id,
      "referenceable_type" => "Relation",
      "url"                => nil,
      "comment"            => "a comment" })
  end

  after do
    Reference.delete_all
    Relation.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
