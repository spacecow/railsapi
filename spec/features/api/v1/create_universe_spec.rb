require 'rails_helper'

describe 'Create universe' do
  let(:params){ {universe:{title:'Malazan'}} }
  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :post, api_universes_path, params }
  let(:body){ JSON.parse page.text }

  context "universe is valid" do
    it "a universe is created" do
      expect(Universe.count).to be 0
      function
      expect(Universe.count).to be 1
      expect(body["universe"]).to eq({
        "id" => Universe.first.id,
        "title" => 'Malazan' })
    end
  end
  
  context "title is null" do
    let(:params){ {universe:{name:'Malazan'}} }
    it "universe is not created" do
      expect(Universe.count).to be 0
      function
      expect(Universe.count).to be 0
      expect(body['universe']['title']).to eq 'cannot be null' 
    end
  end

  context "universe is missing" do
    let(:params){ {} }
    it "universe is not created" do
      expect(Universe.count).to be 0
      function
      expect(Universe.count).to be 0
      expect(body['universe']).to eq 'is missing' 
    end
  end

  context "universe is duplicated" do
    it "universe is not created" do
      create :universe, title:'Malazan'
      expect(Universe.count).to be 1
      function
      expect(Universe.count).to be 1
      expect(body['universe']['title']).to eq 'is already taken' 
    end
  end

  after{ Universe.delete_all }

end
