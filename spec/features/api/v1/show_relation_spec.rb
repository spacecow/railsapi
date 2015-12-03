require 'rails_helper'

describe "Show relation" do

  let(:response){ JSON.parse(page.text)['relation'] }
  let(:relation){ create :relation, type:"Husband" }
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
        'comment'    => "yeah" }] })
  end

  after do
    Reference.delete_all
    Relation.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
