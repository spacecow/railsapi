require 'rails_helper'

describe "Show relation" do

  let(:response){ JSON.parse(page.text)['relation'] }
  let(:wife){ create :article, name:"The Wife", gender:'f' } 
  let(:husband){ create :article, name:"The Husband", gender:'m' }
  let(:relation){ create :relation, type:"Husband", origin:wife, target:husband }
  let(:reference){ create :reference, referenceable:relation, comment:"yeah" }

  before do
    reference
    visit api_relation_path relation
  end

  it "Exists" do
    expect(response).to eq({
      'id'         => relation.id,
      'type'       => "Husband",
      'references' => [{
        'id'         => reference.id,
        'comment'    => "yeah" }],
      'origin'     => {
        'id'         => relation.origin_id,
        'gender'     => 'f',
        'name'       => "The Wife" },
      'target'     => {
        'id'         => relation.target_id,
        'gender'     => 'm',
        'name'       => "The Husband" }
    })
  end

  after do
    Reference.delete_all
    Relation.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
