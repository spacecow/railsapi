require 'rails_helper'

describe 'Create article' do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse page.text }
  let(:path){ send "api_#{mdl.pluralize}_path" }

  let(:mdl){ "article" }
  let(:universe){ create :universe }
  let(:universe_id){ universe.id }
  let(:name){ 'Kelsier' }
  let(:type){ 'Character' }
  let(:params){ {article:{name:name, type:type,
    universe_id:universe_id, gender:'m'}} }

  subject{ ->{ driver.submit :post, api_articles_path, params }}

  context "article is valid" do
    it "an article is created" do
      should change(Article,:count).from(0).to(1)
      expect(response["article"]).to eq({
        'id'          => Article.first.id,
        'name'        => 'Kelsier',
        'type'        => 'Character',
        'universe_id' => universe.id,
        'gender'      => 'm',
        'events'      => [],
        'notes'       => [],
        'citations'   => [],
        'tags'        => []
      })
    end
  end

  context "no universe is selected" do
    let(:universe_id){ nil }
    it "article is not created" do
      should_not change(Article,:count)
      expect(response['universe']['id']).to eq 'is not found' 
    end
  end

  context "a non-existing universe is selected" do
    let(:universe_id){ -1 }
    it "article is not created" do
      should_not change(Article,:count)
      expect(response['universe']['id']).to eq 'is not found' 
    end
  end

  context "name is blank" do
    let(:name){ '' }
    it "article is not created" do
      should_not change(Article,:count)
      expect(response['article']['name']).to eq 'cannot be blank' 
    end
  end

  context "type is invalid" do
    let(:type){ 'Superman' }
    it "article is not created" do
      should_not change(Article,:count)
      expect(response['article']['type']).to eq 'is invalid' 
    end
  end

  after do
    Article.delete_all
    Universe.delete_all
  end

end
