require 'rails_helper'

describe "Show relation" do

  let(:response){ JSON.parse(page.text)['relation'] }
  let(:relation){ create :relation, type:"Husband" }

  before do
    visit api_relation_path relation
  end

  it "Exists" do
    expect(response).to eq({
      'type'           => "Husband" 
    })
  end

  after do
    Relation.delete_all
    Article.delete_all
    Universe.delete_all
  end

end
