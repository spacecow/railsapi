require 'rails_helper'

describe "Create tag" do

  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit mode, path, params }
  let(:response){ JSON.parse(page.text)[mdl] }
  let(:header){ driver.header 'Accept', 'application/vnd.example.v1' }
  let(:path){ send "api_#{mdl.pluralize}_path" }

  let(:tag){ Tag.first }
  let(:universe){ create :universe }
  let(:mode){ :post }
  let(:params){{ tag:{ title:'TDP', universe_id:universe.id }}}
  let(:mdl){ "tag" }

  before{ header; universe }

  subject{ ->{ function }}

  it "a tag is created" do
    should change(Tag, :count).from(0).to(1).and(
           not_change(Universe, :count).from(1)).and(
           not_change(Article, :count).from(0)).and(
           not_change(Note, :count).from(0))
    expect(response).to eq({
      "id" => tag.id,
      "title" => 'TDP',
      "universe_id" => universe.id
    })
  end

  after do
    Tag.delete_all
    Universe.delete_all
  end

end
